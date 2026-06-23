import 'dart:io';
import 'dart:typed_data' show Uint8List;

import 'package:flutter_test/flutter_test.dart';
import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/helpers/zstd_wrapper.dart';
import 'package:gtfs_proto_flutter/src/loader.dart';
import 'package:gtfs_proto_flutter/src/models.dart';
import 'package:gtfs_proto_flutter/src/queries.dart';
import 'package:latlong2/latlong.dart' show LatLng;
import 'package:libcompress/libcompress.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TestZstdDecompressor implements ZstdDecompressor {
  final zstd = ZstdCodec();

  @override
  Future<Uint8List?> decompress(Uint8List data) => zstd.decompressAsync(data);
}

void main() {
  test('Loads everything correctly', () async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    final helper = DatabaseHelper(databaseName: inMemoryDatabasePath);
    final loader = ProtoLoader(helper, decompressor: TestZstdDecompressor());
    final file = File('test/fixture/feed.gtp');
    await loader.loadFromBytes('feed', file.readAsBytesSync());
    // await loader.loadFromBytes('feed', file.readAsBytesSync(), (stage, p) => print('$stage $p%'));

    final queries = Queries(helper);
    final feedId = await queries.feeds.getByName('feed');
    expect(feedId, isNotNull);

    expect(await queries.stops.getAllStops('feed'), hasLength(7));
    final stop3 = await queries.stops.getByCode('feed', '0010-03');
    expect(stop3, isNotNull);
    expect(stop3!.gtfsId, 'stop3');
    expect(stop3.name, 'Stop 3');
    expect(stop3.type, LocationType.stop);
    expect(stop3.location, LatLng(41.8911, 12.4930));
    expect(stop3.accessibility, Accessibility.no);
  });
}
