import 'dart:io';
import 'dart:typed_data';

import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/helpers/null_if_empty.dart';
import 'package:gtfs_proto_flutter/src/helpers/rolling_map.dart';
import 'package:gtfs_proto_flutter/src/helpers/zstd_wrapper.dart';
import 'package:gtfs_proto_flutter/src/helpers/just_date.dart';
import 'package:gtfs_proto_flutter/src/models.dart' as m;
import 'package:gtfs_proto_flutter/src/queries/agency.dart';
import 'package:gtfs_proto_flutter/src/queries/itinerary.dart';
import 'package:gtfs_proto_flutter/src/queries/route.dart';
import 'package:gtfs_proto_flutter/src/queries/stop.dart';
import 'package:gtfs_proto_flutter/src/queries/trip.dart';
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

enum LoaderStage {
  init,
  header,
  ids,
  strings,
  agency,
  services,
  shapes,
  stops,
  routes,
  itineraries,
  trips,
  transfers,
  networks,
  areas,
  finalize,
  done,
}

typedef LoaderCallback = void Function(LoaderStage stage, int percent);

class ProtoLoader {
  final DatabaseHelper _database;
  final ZstdDecompressor _decompressor;

  ProtoLoader(DatabaseHelper database, {ZstdDecompressor? decompressor})
    : _database = database,
      _decompressor = decompressor ?? DefaultZstdDecompressor();

  Future<void> loadFromBytes(String feedName, Uint8List data, [LoaderCallback? callback]) async {
    callback?.call(LoaderStage.init, 0);
    if (data.length < 6) {
      throw ProtoLoadException("Data is only ${data.length} bytes long");
    }
    if (data[0] != 0x54 || data[3] != 0x0A) {
      throw ProtoLoadException("Incorrect header");
    }

    bool isDelta;
    if (data[1] == 0x46)
      isDelta = false;
    else if (data[1] == 0x44)
      isDelta = true;
    else
      throw ProtoLoadException("Incorrect header");

    int version = data[2] - 0x30;
    if (version != 1) throw ProtoLoadException("Unsupported schema version: $version");

    final int headerLength = data[4] * 256 + data[5];
    if (data.length < 6 + headerLength)
      throw ProtoLoadException("Header length is $headerLength, bigger than data size ${data.length}");

    final db = await _database.database;
    callback?.call(LoaderStage.header, 1);
    await db.transaction((txn) async {
      if (isDelta) {
        final header = gtfs.GtfsDeltaHeader.fromBuffer(Uint8List.sublistView(data, 6, 6 + headerLength));
        final feed = await _fetchOrCreateFeed(txn, feedName, header.version, false);
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
          callback,
        );
        await txn.delete(m.DateServices.kTable.name, where: 'feed_id = ?', whereArgs: [feed.id]);
      } else {
        final header = gtfs.GtfsHeader.fromBuffer(Uint8List.sublistView(data, 6, 6 + headerLength));
        final feed = await _fetchOrCreateFeed(txn, feedName, header.version, true);
        await _clearFeed(txn, feed.id);
        await _loadFeed(
          txn,
          feed,
          header.blocks,
          header.compressed,
          false,
          Uint8List.sublistView(data, 6 + headerLength),
          callback,
        );
      }
    });
    callback?.call(LoaderStage.finalize, 99);

    // TODO: vacuum
    callback?.call(LoaderStage.done, 100);
  }

  Future<void> _clearFeed(Transaction txn, int feedId) async {
    for (final table in DatabaseHelper.kTables) {
      if (table == Feed.kTable) continue;
      if (table.key == null || !table.columns.any((c) => c.startsWith('feed_id integer'))) continue;
      await txn.delete(table.name, where: 'feed_id = ?', whereArgs: [feedId]);
    }
  }

  Future<Feed> _fetchOrCreateFeed(Transaction txn, String feedName, int version, bool canCreate) async {
    final feed = (await txn.rawQuery('select * from ${m.Feed.kTable.name} where feed_name = ?', [
      feedName,
    ])).map((row) => m.Feed.fromJson(row)).firstOrNull;
    if (feed != null) return feed;

    if (!canCreate) throw ProtoLoadException("Unknown feed name \"$feedName\" for loading a delta");

    final newFeed = Feed(id: -1, name: feedName, version: version);
    final newId = await txn.insert(Feed.kTable.name, newFeed.toJson());
    return newFeed.withId(newId);
  }

  List<int> _preparePercents(List<int> blocks) {
    final sum = blocks.fold(0, (a, b) => a + b);
    const percentSpan = 98.0;
    return blocks.rollingMap(1.0, (prev, size) => prev + percentSpan * size / sum).map((v) => v.round()).toList();
  }

  Future<void> _loadFeed(
    Transaction txn,
    Feed feed,
    List<int> blocks,
    bool compressed,
    bool isDelta,
    Uint8List data,
    LoaderCallback? callback,
  ) async {
    int offset = 0;
    final percents = _preparePercents(blocks);
    const stages = [
      LoaderStage.header,
      LoaderStage.ids,
      LoaderStage.strings,
      LoaderStage.agency,
      LoaderStage.services,
      LoaderStage.shapes,
      LoaderStage.stops,
      LoaderStage.routes,
      LoaderStage.itineraries,
      LoaderStage.trips,
      LoaderStage.transfers,
      LoaderStage.networks,
      LoaderStage.areas,
    ];
    final Map<gtfs.Block, List<String>> idRefs = {};
    final List<String> strings = [];
    int? agencyId;
    for (int blockId = 1; blockId < blocks.length; blockId++) {
      if (blocks[blockId - 1] == 0) continue;

      if (blockId < stages.length) callback?.call(stages[blockId], percents[blockId]);
      Uint8List block = Uint8List.sublistView(data, offset, offset + blocks[blockId - 1]);
      if (compressed) {
        final decompressed = await _decompressor.decompress(block);
        if (decompressed == null) {
          throw ProtoLoadException("Failed to decompress a block for ${gtfs.Block.values[blockId]}");
        }
        block = decompressed;
      }
      offset += blocks[blockId - 1];

      if (blockId == gtfs.Block.B_IDS.value) {
        final idStore = gtfs.IdStore.fromBuffer(block);
        for (final refs in idStore.refs) {
          // TODO: delta_skip
          idRefs[refs.block] = refs.ids;
        }
      } else if (blockId == gtfs.Block.B_STRINGS.value) {
        final str = gtfs.StringTable.fromBuffer(block);
        strings.addAll(str.strings);
      } else if (blockId == gtfs.Block.B_AGENCY.value) {
        agencyId = await _loadAgencies(txn, feed.id, idRefs[gtfs.Block.B_AGENCY]!, isDelta, block);
      } else if (blockId == gtfs.Block.B_SERVICES.value) {
        await _loadServices(txn, feed.id, idRefs[gtfs.Block.B_SERVICES]!, isDelta, block);
      } else if (blockId == gtfs.Block.B_SHAPES.value) {
        await _loadShapes(txn, feed.id, idRefs[gtfs.Block.B_SHAPES]!, isDelta, block);
      } else if (blockId == gtfs.Block.B_STOPS.value) {
        await _loadStops(txn, feed.id, idRefs[gtfs.Block.B_STOPS]!, strings, isDelta, block);
      } else if (blockId == gtfs.Block.B_ROUTES.value) {
        await _loadRoutes(txn, feed.id, agencyId, idRefs[gtfs.Block.B_ROUTES]!, strings, isDelta, block);
      } else if (blockId == gtfs.Block.B_ITINERARIES.value) {
        await _loadItineraries(txn, feed.id, idRefs[gtfs.Block.B_ITINERARIES]!, strings, isDelta, block);
      } else if (blockId == gtfs.Block.B_TRIPS.value) {
        await _loadTrips(txn, feed.id, idRefs[gtfs.Block.B_TRIPS]!, strings, isDelta, block);
      } else if (blockId == gtfs.Block.B_TRANSFERS.value) {
        await _loadTransfers(txn, feed.id, isDelta, block);
      } else if (blockId == gtfs.Block.B_NETWORKS.value) {
        await _loadNetworks(txn, feed.id, idRefs[gtfs.Block.B_NETWORKS]!, isDelta, block);
      } else if (blockId == gtfs.Block.B_AREAS.value) {
        await _loadAreas(txn, feed.id, idRefs[gtfs.Block.B_AREAS]!, isDelta, block);
      } else {
        throw ProtoLoadException("Unknown block encountered: $blockId");
      }
    }
  }

  Future<int?> _loadAgencies(Transaction txn, int feedId, List<String> gtfsIds, bool isDelta, Uint8List block) async {
    final agencies = gtfs.Agencies.fromBuffer(block);
    final batch = txn.batch();
    final agencyIds = <int>[];
    for (final agency in agencies.agencies) {
      agencyIds.add(agency.agencyId);
      final lastAgency = isDelta ? await AgencyQueries.queryById(txn, FeedId(feedId, agency.agencyId)) : null;
      final dbAgency = m.Agency.fromProto(feedId, gtfsIds[agency.agencyId], agency, lastAgency);
      batch.insert(m.Agency.kTable.name, dbAgency.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
    return agencyIds.length == 1 ? agencyIds.first : null;
  }

  Future<void> _loadServices(Transaction txn, int feedId, List<String> gtfsIds, bool isDelta, Uint8List block) async {
    final services = gtfs.Services.fromBuffer(block);
    final baseDateMatch = RegExp(r'^(\d\d\d\d)(\d\d)(\d\d)$').matchAsPrefix(services.baseDate.toString());
    if (baseDateMatch == null) {
      throw ProtoLoadException("Failed to parse the base date in Services: ${services.baseDate}");
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
          throw ProtoLoadException("Service deletion encountered in a feed: ${service.serviceId}");
        }
        batch.delete(
          m.Service.kTable.name,
          where: 'feed_id = ? and service_id = ?',
          whereArgs: [feedId, service.serviceId],
        );
      } else {
        final dbService = m.Service.fromProto(feedId, gtfsIds[service.serviceId], baseDate, service);
        final algo = isDelta ? ConflictAlgorithm.replace : ConflictAlgorithm.rollback;
        batch.insert(m.Service.kTable.name, dbService.toJson(), conflictAlgorithm: algo);
      }
    }
    await batch.commit();
  }

  Future<void> _loadShapes(Transaction txn, int feedId, List<String> gtfsIds, bool isDelta, Uint8List block) async {
    final shapes = gtfs.Shapes.fromBuffer(block);
    final batch = txn.batch();
    LatLng lastLoc = LatLng(0, 0);
    for (final shape in shapes.shapes) {
      if (shape.latitudes.isEmpty || shape.longitudes.isEmpty) {
        if (!isDelta) {
          throw ProtoLoadException("Shape deletion found in a feed: ${shape.shapeId}");
        }
        batch.delete(m.Shape.kTable.name, where: 'feed_id = ? and shape_id = ?', whereArgs: [feedId, shape.shapeId]);
      } else {
        final dbShape = m.Shape.fromProto(feedId, gtfsIds[shape.shapeId], lastLoc, shape);
        lastLoc = dbShape.path.last;
        final algo = isDelta ? ConflictAlgorithm.replace : ConflictAlgorithm.rollback;
        batch.insert(m.Shape.kTable.name, dbShape.toJson(), conflictAlgorithm: algo);
      }
    }
    await batch.commit();
  }

  Future<void> _loadStops(
    Transaction txn,
    int feedId,
    List<String> gtfsIds,
    List<String> strings,
    bool isDelta,
    Uint8List block,
  ) async {
    final stops = gtfs.Stops.fromBuffer(block);
    final batch = txn.batch();
    LatLng lastLoc = LatLng(0, 0);
    for (final stop in stops.stops) {
      if (stop.delete) {
        if (!isDelta) {
          throw ProtoLoadException("Stop deletion encountered in a feed: ${stop.stopId}");
        }
        batch.delete(m.Stop.kTable.name, where: 'feed_id = ? and stop_id = ?', whereArgs: [feedId, stop.stopId]);
      } else {
        final lastStop = isDelta ? await StopQueries.queryById(txn, FeedId(feedId, stop.stopId)) : null;
        final dbStop = m.Stop.fromProto(feedId, gtfsIds[stop.stopId], strings, lastLoc, stop, lastStop);
        if (stop.lon != 0 || stop.lat != 0) lastLoc = dbStop.location;
        final algo = isDelta ? ConflictAlgorithm.replace : ConflictAlgorithm.rollback;
        batch.insert(m.Stop.kTable.name, dbStop.toJson(), conflictAlgorithm: algo);
      }
    }
    await batch.commit();
  }

  Future<void> _loadRoutes(
    Transaction txn,
    int feedId,
    int? agencyId,
    List<String> gtfsIds,
    List<String> strings,
    bool isDelta,
    Uint8List block,
  ) async {
    if (isDelta) {
      // We do not believe agencyId for deltas, better get it from the database.
      agencyId = await AgencyQueries.querySingleId(txn, feedId);
    }
    final routes = gtfs.Routes.fromBuffer(block);
    final batch = txn.batch();
    for (final route in routes.routes) {
      if (route.delete) {
        if (!isDelta) {
          throw ProtoLoadException("Route deletion encountered in a feed: ${route.routeId}");
        }
        batch.delete(m.Route.kTable.name, where: 'feed_id = ? and route_id = ?', whereArgs: [feedId, route.routeId]);
      } else {
        final lastRoute = isDelta ? await RouteQueries.queryById(txn, FeedId(feedId, route.routeId)) : null;
        final dbRoute = m.Route.fromProto(feedId, gtfsIds[route.routeId], agencyId, strings, route, lastRoute);
        final algo = isDelta ? ConflictAlgorithm.replace : ConflictAlgorithm.rollback;
        batch.insert(m.Route.kTable.name, dbRoute.toJson(), conflictAlgorithm: algo);
      }
    }
    await batch.commit();
  }

  Future<void> _loadItineraries(
    Transaction txn,
    int feedId,
    List<String> gtfsIds,
    List<String> strings,
    bool isDelta,
    Uint8List block,
  ) async {
    final itineraries = gtfs.Itineraries.fromBuffer(block);
    final batch = txn.batch();
    for (final itinerary in itineraries.itineraries) {
      batch.delete(
        m.ItineraryStopRef.kTable.name,
        where: 'feed_id = ? and itinerary_id = ?',
        whereArgs: [feedId, itinerary.itineraryId],
      );
      if (itinerary.routeId == 0) {
        if (!isDelta) {
          throw ProtoLoadException("Itinerary deletion encountered in a feed: ${itinerary.routeId}");
        }
        batch.delete(
          m.Itinerary.kTable.name,
          where: 'feed_id = ? and itinerary_id = ?',
          whereArgs: [feedId, itinerary.itineraryId],
        );
      } else {
        final lastItin = isDelta ? await ItineraryQueries.queryById(txn, FeedId(feedId, itinerary.itineraryId)) : null;
        final dbItin = m.Itinerary.fromProto(feedId, strings, itinerary, lastItin);
        final algo = isDelta ? ConflictAlgorithm.replace : ConflictAlgorithm.rollback;
        batch.insert(m.Itinerary.kTable.name, dbItin.toJson(), conflictAlgorithm: algo);
        for (final stopRef in dbItin.toStopRefs()) {
          batch.insert(m.ItineraryStopRef.kTable.name, stopRef.toJson());
        }
      }
    }
    await batch.commit();
  }

  Future<void> _loadTrips(
    Transaction txn,
    int feedId,
    List<String> gtfsIds,
    List<String> strings,
    bool isDelta,
    Uint8List block,
  ) async {
    final trips = gtfs.Trips.fromBuffer(block);
    final batch = txn.batch();
    for (final trip in trips.trips) {
      if (trip.itineraryId == 0) {
        if (!isDelta) {
          throw ProtoLoadException("Trip deletion encountered in a feed: ${trip.tripId}");
        }
        batch.delete(m.Trip.kTable.name, where: 'feed_id = ? and trip_id = ?', whereArgs: [feedId, trip.tripId]);
      } else {
        final lastTrip = isDelta ? await TripQueries.queryById(txn, FeedId(feedId, trip.tripId)) : null;
        final dbTrip = m.Trip.fromProto(feedId, gtfsIds[trip.tripId], trip, lastTrip);
        final algo = isDelta ? ConflictAlgorithm.replace : ConflictAlgorithm.rollback;
        batch.insert(m.Trip.kTable.name, dbTrip.toJson(), conflictAlgorithm: algo);
      }
    }
    await batch.commit();
  }

  Future<void> _loadTransfers(Transaction txn, int feedId, bool isDelta, Uint8List block) async {
    final transfers = gtfs.Transfers.fromBuffer(block);
    final batch = txn.batch();
    for (final transfer in transfers.transfers) {
      final dbTransfer = m.Transfer.fromProto(feedId, transfer);
      if (transfer.delete) {
        if (!isDelta) {
          throw ProtoLoadException("Transfer deletion encountered in a feed: $transfer");
        }
        batch.delete(
          m.Transfer.kTable.name,
          where: 'feed_id = ? and transfer_id = ?',
          whereArgs: [feedId, dbTransfer.databaseId],
        );
      } else {
        batch.insert(m.Transfer.kTable.name, dbTransfer.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
    await batch.commit();
  }

  Future<void> _loadNetworks(Transaction txn, int feedId, List<String> gtfsIds, bool isDelta, Uint8List block) async {
    final networks = gtfs.Networks.fromBuffer(block);
    final batch = txn.batch();
    for (final network in networks.networks.entries) {
      final dbNetwork = m.Network(
        id: FeedId(feedId, network.key),
        gtfsId: gtfsIds[network.key],
        name: network.value.nullIfEmpty,
      );
      final algo = isDelta ? ConflictAlgorithm.replace : ConflictAlgorithm.rollback;
      batch.insert(m.Network.kTable.name, dbNetwork.toJson(), conflictAlgorithm: algo);
    }
    await batch.commit();
  }

  Future<void> _loadAreas(Transaction txn, int feedId, List<String> gtfsIds, bool isDelta, Uint8List block) async {
    final areas = gtfs.Areas.fromBuffer(block);
    final batch = txn.batch();
    for (final area in areas.areas.entries) {
      final dbArea = m.Area(id: FeedId(feedId, area.key), gtfsId: gtfsIds[area.key], name: area.value.nullIfEmpty);
      final algo = isDelta ? ConflictAlgorithm.replace : ConflictAlgorithm.rollback;
      batch.insert(m.Area.kTable.name, dbArea.toJson(), conflictAlgorithm: algo);
    }
    await batch.commit();
  }
}
