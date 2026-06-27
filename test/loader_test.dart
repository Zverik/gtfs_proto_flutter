import 'dart:io';
import 'dart:typed_data' show Uint8List;
import 'dart:ui' show Color;

import 'package:flutter_test/flutter_test.dart';
import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/helpers/just_date.dart';
import 'package:gtfs_proto_flutter/src/helpers/just_time.dart';
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
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  final helper = DatabaseHelper(databaseName: inMemoryDatabasePath);
  final loader = ProtoLoader(helper, decompressor: TestZstdDecompressor());
  final queries = Queries(helper);

  test('Loads everything correctly', () async {
    final file = File('test/fixture/feed.gtp');
    await loader.loadFromBytes('feed', file.readAsBytesSync());
    // await loader.loadFromBytes('feed', file.readAsBytesSync(), (stage, p) => print('$stage $p%'));

    final feedId = await queries.feeds.getByName('feed');
    expect(feedId, isNotNull);
  });

  test('Stops are okay', () async {
    expect(await queries.stops.getAllStops('feed'), hasLength(7));
    final stop3 = await queries.stops.getByCode('feed', '0010-03');
    expect(stop3, isNotNull);
    expect(stop3!.gtfsId, 'stop3');
    expect(stop3.name, 'Stop 3');
    expect(stop3.type, LocationType.stop);
    expect(stop3.location, LatLng(41.8911, 12.4930));
    expect(stop3.accessibility, Accessibility.no);
  });

  test('Routes and agencies are okay', () async {
    final route = await queries.routes.getByGtfsId('feed', 'ROUTE2');
    expect(route, isNotNull);
    expect(route!.agencyId.id, greaterThan(0));
    expect(route.name, 'T1');
    expect(route.longName, 'another route');
    expect(route.routeType, RouteType.tram);
    expect(route.color, Color(0xFFBBEECC));

    final agency = await queries.agencies.getById(route.agencyId);
    expect(agency, isNotNull);
    expect(agency!.name, 'Nonesuch Transit');
  });

  test('Itineraries and shapes are okay', () async {
    final stop1 = await queries.stops.getByGtfsId('feed', 'stop1');
    expect(stop1, isNotNull);

    final itineraries = await queries.itineraries.getForStops([stop1!.id]);
    expect(itineraries, isNotEmpty, reason: 'For stop ${stop1.id}');
    final itinerary = itineraries.where((i) => i.stops.first.headsign == 'There').firstOrNull;
    expect(itinerary, isNotNull);
    expect(itinerary!.stops, hasLength(4));
    expect(itinerary.stops.map((s) => s.headsign).toSet(), equals({'There'}));
    expect(itinerary.shapeId, isNotNull);

    final shape = await queries.shapes.getById(itinerary.shapeId!);
    expect(shape, isNotNull);
    expect(shape!.gtfsId, 'dontcare');
    expect(shape.path, hasLength(3));
    expect(shape.path, [LatLng(41.89, 12.492), LatLng(41.891, 12.492), LatLng(41.891, 12.493)]);
  });

  test('Regular trips are okay', () async {
    final trip = await queries.trips.getByGtfsId('feed', 'tram_work');
    expect(trip, isNotNull);
    expect(trip!.name, isNull);
    expect(trip.wheelchair, Accessibility.some);
    expect(trip.bikes, Accessibility.unknown);
    expect(trip.startTime, JustTime(12, 0, 0));
    expect(trip.endTime, JustTime(19, 0, 0));
    expect(trip.interval, 1200);
    expect(trip.departures, [JustTime(6, 0, 0), JustTime(6, 10, 30), JustTime(6, 30, 0)]);
    expect(trip.arrivals, [JustTime(6, 0, 0), JustTime(6, 10, 0), JustTime(6, 30, 0)]);

    final itin = await queries.itineraries.getById(trip.itineraryId);
    expect(itin, isNotNull);
    expect(itin!.stops.map((s) => s.headsign).toList(), ['Airport', 'Missing', 'Airport']);
    expect(itin.stops.first.pickup, PickupDropoff.yes);
    expect(itin.stops.first.dropoff, PickupDropoff.no);
    expect(itin.stops.last.pickup, PickupDropoff.no);
    expect(itin.stops.last.dropoff, PickupDropoff.yes);
  });

  test('Trips with empty departures are fine', () async {
    final trip = await queries.trips.getByGtfsId('feed', 'bus5');
    expect(trip, isNotNull);
    expect(trip!.name, 'jaanireis');
    expect(trip.wheelchair, Accessibility.no);
    expect(trip.bikes, Accessibility.unknown);
    expect(trip.startTime, isNull);
    expect(trip.endTime, isNull);
    expect(trip.interval, isNull);

    expect(trip.arrivals, hasLength(4));
    expect(trip.departures, hasLength(4));
    expect(trip.arrivals.first, JustTime(12, 0, 0));
    expect(trip.departures.first, JustTime(12, 0, 30));
    expect(trip.arrivals.last, JustTime(12, 20, 0));
    expect(trip.departures.last, JustTime(12, 20, 0));

    final itin = await queries.itineraries.getById(trip.itineraryId);
    expect(itin, isNotNull);
    expect(itin!.stops.map((s) => s.headsign).toSet(), {'There'});
    expect(itin.stops.first.pickup, PickupDropoff.yes);
    expect(itin.stops.first.dropoff, PickupDropoff.no);
  });

  test('Services are okay', () async {
    final service = await queries.services.getByGtfsId('feed', 'workdays');
    expect(service, isNotNull);
    expect(service!.start, JustDate(2026, 1, 1));
    expect(service.end, JustDate(2026, 12, 31));
    expect(service.weekdays, [true, true, true, true, true, false, false]);
    expect(service.added, isEmpty);
    expect(service.removed.toSet(), {JustDate(2026, 6, 23), JustDate(2026, 6, 24)});

    final service2 = await queries.services.getByGtfsId('feed', 'jaanipaev');
    expect(service2, isNotNull);
    expect(service2!.start, isNull);
    expect(service2.end, isNull);
    expect(service2.removed, isEmpty);
    expect(service2.added.toSet(), {JustDate(2026, 6, 23), JustDate(2026, 6, 24)});
  });

  test('Loads a delta correctly', () async {
    final file = File('test/fixture/delta.gtp');
    await loader.loadFromBytes('feed', file.readAsBytesSync());
    // TODO
  });
}
