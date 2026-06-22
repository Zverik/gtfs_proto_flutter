import 'dart:io';
import 'dart:typed_data' show Uint8List;

import 'package:flutter_test/flutter_test.dart';
import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/helpers/zstd_wrapper.dart';
import 'package:gtfs_proto_flutter/src/loader.dart';
import 'package:gtfs_proto_flutter/src/queries/all.dart';
import 'package:libcompress/libcompress.dart';
import 'package:sqflite/sqflite.dart';
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
    await loader.loadFromBytes('test', file.readAsBytesSync());

    final queries = Queries(helper);
    final feedId = await queries.feeds.getByName('test');
    expect(feedId, isNotNull);
  });
}