import 'dart:io';
import 'dart:typed_data';

import 'package:gtfs_proto_flutter/src/helpers/zstd_wrapper.dart';
import 'package:gtfs_proto_flutter/src/helpers/just_date.dart';
import 'package:gtfs_proto_flutter/src/models/agency.dart';
import 'package:gtfs_proto_flutter/src/models/service.dart';
import 'package:gtfs_proto_flutter/src/models/shape.dart';
import 'package:gtfs_proto_flutter/src/models/stop.dart';
import 'package:latlong2/latlong.dart';
import 'package:sqflite/sqflite.dart';
import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/models/feed.dart';
import 'package:gtfs_proto_flutter/src/proto/gtfs.pb.dart' as gtfs;

class ProtoLoadException extends IOException {
  final String message;

  ProtoLoadException(this.message);

  @override
  String toString() => 'ProtoLoadException($message)';
}

class ProtoLoader {
  final DatabaseHelper _database;
  final ZstdDecompressor _decompressor;

  ProtoLoader(DatabaseHelper database, {ZstdDecompressor? decompressor})
    : _database = database,
      _decompressor = decompressor ?? DefaultZstdDecompressor();

  Future<void> loadFromBytes(String feedName, Uint8List data) async {
    if (data.length < 6) {
      throw ProtoLoadException("Data is only ${data.length} bytes long");
    }
    if (data[0] != 0x54 || data[3] != 0x0A) {
      throw ProtoLoadException("Incorrect header");
    }
    bool isDelta;
    if (data[1] == 0x46) {
      isDelta = false;
    } else if (data[1] == 0x44) {
      isDelta = true;
    } else {
      throw ProtoLoadException("Incorrect header");
    }
    int version = data[2] - 0x30;
    if (version != 1) {
      throw ProtoLoadException("Unsupported schema version: $version");
    }
    final int headerLength = data[4] * 256 + data[5];
    if (data.length < 6 + headerLength) {
      throw ProtoLoadException(
        "Header length is $headerLength, bigger than data size ${data.length}",
      );
    }

    final db = await _database.database;
    await db.transaction((txn) async {
      if (isDelta) {
        final header = gtfs.GtfsDeltaHeader.fromBuffer(
          Uint8List.sublistView(data, 6, 6 + headerLength),
        );
        final feed = await _fetchOrCreateFeed(
          txn,
          feedName,
          header.version,
          false,
        );
        if (header.oldVersion > feed.version) {
          throw ProtoLoadException(
            "Delta is from a newer feed version (${header.oldVersion}) than we have (${feed.version})",
          );
        }
        await _loadFeed(
          txn,
          feed,
          header.blocks,
          header.compressed,
          true,
          Uint8List.sublistView(data, 6 + headerLength),
        );
      } else {
        final header = gtfs.GtfsHeader.fromBuffer(
          Uint8List.sublistView(data, 6, 6 + headerLength),
        );
        final feed = await _fetchOrCreateFeed(
          txn,
          feedName,
          header.version,
          true,
        );
        await _loadFeed(
          txn,
          feed,
          header.blocks,
          header.compressed,
          false,
          Uint8List.sublistView(data, 6 + headerLength),
        );
      }
    });
  }

  Future<Feed> _fetchOrCreateFeed(
    Transaction txn,
    String feedName,
    int version,
    bool canCreate,
  ) async {
    final result = await txn.rawQuery(
      'select * from ${Feed.kTable.name} where name = ?',
      [feedName],
    );
    final feed = result.map((row) => Feed.fromJson(row)).firstOrNull;
    if (feed != null) return feed;

    if (!canCreate) {
      throw ProtoLoadException(
        "Unknown feed name \"$feedName\" for loading a delta",
      );
    }

    final newFeed = Feed(id: -1, name: feedName, version: version);
    final newId = await txn.insert(Feed.kTable.name, newFeed.toJson());
    return newFeed.withId(newId);
  }

  Future<void> _loadFeed(
    Transaction txn,
    Feed feed,
    List<int> blocks,
    bool compressed,
    bool isDelta,
    Uint8List data,
  ) async {
    int offset = 0;
    final Map<gtfs.Block, gtfs.IdReference> idRefs = {};
    final List<String> strings = [];
    for (int blockId = 1; blockId < blocks.length; blockId++) {
      if (blocks[blockId - 1] == 0) continue;

      Uint8List block = Uint8List.sublistView(
        data,
        offset,
        offset + blocks[blockId - 1],
      );
      if (compressed) {
        final decompressed = await _decompressor.decompress(block);
        if (decompressed == null) {
          throw ProtoLoadException(
            "Failed to decompress a block for ${gtfs.Block.values[blockId]}",
          );
        }
        block = decompressed;
      }
      offset += blocks[blockId - 1];

      if (blockId == gtfs.Block.B_IDS.value) {
        final idStore = gtfs.IdStore.fromBuffer(block);
        for (final refs in idStore.refs) {
          idRefs[refs.block] = refs;
        }
      } else if (blockId == gtfs.Block.B_STRINGS.value) {
        final str = gtfs.StringTable.fromBuffer(block);
        strings.addAll(str.strings);
      } else if (blockId == gtfs.Block.B_AGENCY.value) {
        final agencies = gtfs.Agencies.fromBuffer(block);
        final batch = txn.batch();
        for (final agency in agencies.agencies) {
          final dbAgency = Agency.fromProto(feed.id, agency);
          batch.insert(
            Agency.kTable.name,
            dbAgency.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
        await batch.commit();
      } else if (blockId == gtfs.Block.B_SERVICES.value) {
        final services = gtfs.Services.fromBuffer(block);
        final baseDateMatch = RegExp(
          r'^(\d\d\d\d)(\d\d)(\d\d)$',
        ).matchAsPrefix(services.baseDate.toString());
        if (baseDateMatch == null) {
          throw ProtoLoadException(
            "Failed to parse the base date in Services: ${services.baseDate}",
          );
        }
        JustDate baseDate = JustDate(
          int.parse(baseDateMatch.group(1)!),
          int.parse(baseDateMatch.group(2)!),
          int.parse(baseDateMatch.group(3)!),
        );
        final batch = txn.batch();
        for (final service in services.services) {
          if (service.delete) {
            if (!isDelta) {
              throw ProtoLoadException(
                "Service deletion encountered in a feed: ${service.serviceId}",
              );
            }
            batch.delete(
              Service.kTable.name,
              where: 'feed_id = ? and service_id = ?',
              whereArgs: [feed.id, service.serviceId],
            );
          } else {
            final dbService = Service.fromProto(
              feed.id,
              idRefs[gtfs.Block.B_SERVICES]!.ids[service.serviceId],
              baseDate,
              service,
            );
            batch.insert(
              Service.kTable.name,
              dbService.toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
        }
        await batch.commit();
      } else if (blockId == gtfs.Block.B_SHAPES.value) {
        final shapes = gtfs.Shapes.fromBuffer(block);
        final batch = txn.batch();
        LatLng lastLoc = LatLng(0, 0);
        for (final shape in shapes.shapes) {
          if (shape.latitudes.isEmpty || shape.longitudes.isEmpty) {
            if (!isDelta) {
              throw ProtoLoadException(
                "Shape deletion found in a feed: ${shape.shapeId}",
              );
            }
            batch.delete(
              Shape.kTable.name,
              where: 'feed_id = ? and shape_id = ?',
              whereArgs: [feed.id, shape.shapeId],
            );
          } else {
            final dbShape = Shape.fromProto(
              feed.id,
              idRefs[gtfs.Block.B_SHAPES]!.ids[shape.shapeId],
              lastLoc,
              shape,
            );
            lastLoc = dbShape.path.last;
            batch.insert(
              Shape.kTable.name,
              dbShape.toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
        }
        await batch.commit();
      } else if (blockId == gtfs.Block.B_STOPS.value) {
        final stops = gtfs.Stops.fromBuffer(block);
        final batch = txn.batch();
        LatLng lastLoc = LatLng(0, 0);
        for (final stop in stops.stops) {
          if (stop.delete) {
            if (!isDelta) {
              throw ProtoLoadException(
                "Stop deletion encountered in a feed: ${stop.stopId}",
              );
            }
            batch.delete(
              Stop.kTable.name,
              where: 'feed_id = ? and stop_id = ?',
              whereArgs: [feed.id, stop.stopId],
            );
          } else {
            final dbStop = Stop.fromProto(
              feed.id,
              idRefs[gtfs.Block.B_STOPS]!.ids[stop.stopId],
              strings,
              lastLoc,
              stop,
            );
            lastLoc = dbStop.location;
            batch.insert(
              Stop.kTable.name,
              dbStop.toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
        }
        await batch.commit();
      } else if (blockId == gtfs.Block.B_ROUTES.value) {
      } else if (blockId == gtfs.Block.B_ITINERARIES.value) {
      } else if (blockId == gtfs.Block.B_TRIPS.value) {
      } else if (blockId == gtfs.Block.B_TRANSFERS.value) {
      } else if (blockId == gtfs.Block.B_NETWORKS.value) {
      } else if (blockId == gtfs.Block.B_AREAS.value) {
      } else {
        throw ProtoLoadException("Unknown block encountered: $blockId");
      }
    }
  }
}
