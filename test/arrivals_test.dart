import 'dart:io' show File;

import 'package:flutter_test/flutter_test.dart';
import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/helpers/just_date.dart';
import 'package:gtfs_proto_flutter/src/helpers/just_time.dart';
import 'package:gtfs_proto_flutter/src/helpers/schedule_item.dart';
import 'package:gtfs_proto_flutter/src/loader.dart';
import 'package:gtfs_proto_flutter/src/models.dart';
import 'package:gtfs_proto_flutter/src/queries/arrival.dart';
import 'package:gtfs_proto_flutter/src/queries/route.dart';
import 'package:gtfs_proto_flutter/src/queries/stop.dart';
import 'package:gtfs_proto_flutter/src/queries/trip.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'loader_test.dart' show TestZstdDecompressor;

void main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  final helper = DatabaseHelper(databaseName: inMemoryDatabasePath);
  final loader = ProtoLoader(helper, decompressor: TestZstdDecompressor());
  final file = File('test/fixture/feed.gtp');
  await loader.loadFromBytes('feed', file.readAsBytesSync());

  final arrivals = ArrivalQueries(helper);
  final stops = {for (final stop in await StopQueries(helper).getAllStops('feed')) stop.gtfsId: stop.id};

  test('Schedule for a regular route', () async {
    final bus = (await RouteQueries(helper).getByGtfsId('feed', 'ROUTE1'))?.id;
    expect(bus, isNotNull);
    final deps1 = await arrivals.findDeparturesForDay(bus!, stops['stop1']!, JustDate(2026, 6, 26));
    expect(deps1, isEmpty, reason: 'no service on workdays');

    final deps2 = await arrivals.findDeparturesForDay(bus, stops['stop1']!, JustDate(2026, 6, 27));
    expect(deps2.map((d) => d.departure), [
      JustTime(10, 0, 30),
      JustTime(10, 50, 30),
      JustTime(11, 0, 30),
      JustTime(11, 50, 30),
    ]);

    final deps3 = await arrivals.findDeparturesForDay(bus, stops['stop4']!, JustDate(2026, 6, 23));
    expect(deps3.map((d) => d.departure), [
      JustTime(10, 20),
      JustTime(10, 30),
      JustTime(11, 20),
      JustTime(11, 30),
      JustTime(12, 20),
    ]);
  });

  test('Schedule for a frequency-based route', () async {
    final tram = (await RouteQueries(helper).getByGtfsId('feed', 'ROUTE2'))?.id;
    expect(tram, isNotNull);
    final deps1 = await arrivals.findDeparturesForDay(tram!, stops['stop5']!, JustDate(2026, 6, 27));
    expect(deps1, hasLength((19 - 12) * 3 + 1));
    expect(deps1[1].departure, JustTime(12, 20));
    expect(deps1.last.departure, JustTime(19, 0));

    final deps2 = await arrivals.findDeparturesForDay(tram, stops['stop5']!, JustDate(2026, 6, 26));
    expect(deps2, hasLength(2));
    expect(deps2.first.frequency, Frequency(JustTime(12, 0), JustTime(19, 0), 1200));
  });

  test('Getting all context for a trip', () async {
    final trip = await TripQueries(helper).getByGtfsId('feed', 'bus3');
    expect(trip, isNotNull);
    final specific = await arrivals.getSpecificTrip(
      SpecificTripId(tripId: trip!.id, departure: DateTime(2026, 6, 27, 6, 0, 0)),
    );
    expect(specific, isNotNull);
    expect(specific!.name, 'jaanireis');
    expect(specific.route.name, 'B1');
    expect(specific.path, isNotNull);
    expect(specific.path, hasLength(3));
    expect(specific.frequencySeconds, isNull);
    expect(specific.stops, hasLength(4));
    final stop2 = specific.stops[1];
    expect(stop2.stop.name, 'Stop 2');
    expect(stop2.arrival, DateTime(2026, 6, 27, 11, 10, 0));
    expect(stop2.headsign, 'There');
  });

  test('Arrivals for a time', () async {
    final ar = await arrivals.findArrivals(stopId: stops['stop2']!, now: DateTime(2026, 6, 27, 11, 6, 0));
    expect(ar, hasLength(2));
    expect(ar.map((a) => a.stop.stop.name).toSet(), {'Stop 2'});
    expect(ar.map((a) => a.trip.route.name), ['B1', 'B1']);
    expect(ar.map((a) => a.trip.gtfsId), ['bus3', 'bus4']);
    expect(ar.map((a) => a.stop.departure), [DateTime(2026, 6, 27, 11, 10), DateTime(2026, 6, 27, 11, 40)]);
  });

  test('Arrivals for a frequency', () async {
    final ar2 = await arrivals.findArrivals(stopId: stops['stop7']!, now: DateTime(2026, 6, 26, 10, 6, 0));
    expect(ar2, isEmpty);

    final ar3 = await arrivals.findArrivals(stopId: stops['stop7']!, now: DateTime(2026, 6, 26, 11, 6, 0));
    expect(ar3, hasLength(1));
    expect(ar3.first.trip.frequencySeconds, 1200);
    expect(ar3.first.interval, isTrue);

    final ar4 = await arrivals.findArrivals(stopId: stops['stop7']!, now: DateTime(2026, 6, 26, 14, 6, 0));
    expect(ar4, hasLength(2));
    expect(ar4.map((a) => a.trip.frequencySeconds), [1200, 1200]);
    expect(ar4.map((a) => a.interval), [true, true]);

    // TODO this
    /* final ar5 = await arrivals.findArrivals(stopId: stops['stop7']!, now: DateTime(2026, 6, 27, 14, 6, 0));
    expect(ar5, hasLength(3));
    expect(ar5.first.interval, isFalse);
    expect(ar5.map((a) => a.stop.departure), [
      DateTime(2026, 6, 27, 14, 20),
      DateTime(2026, 6, 27, 14, 40),
      DateTime(2026, 6, 27, 15, 0),
    ]); */
  });

  test('Real-time adjusted arrivals', () async {
    // TODO
  });
}
