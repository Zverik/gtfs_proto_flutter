import 'dart:typed_data';

import 'package:fast_geohash/fast_geohash_str.dart';
import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/helpers/just_date.dart';
import 'package:gtfs_proto_flutter/src/helpers/just_time.dart';
import 'package:gtfs_proto_flutter/src/loader.dart';
import 'package:gtfs_proto_flutter/src/models.dart';
import 'package:gtfs_proto_flutter/src/queries.dart';
import 'package:latlong2/latlong.dart';

class GtfsProto {
  final DatabaseHelper _database;
  late final ProtoLoader _loader;
  late final Queries queries;

  GtfsProto(String databasePath)
    : _database = DatabaseHelper(databaseName: databasePath) {
    _loader = ProtoLoader(_database);
    queries = Queries(_database);
  }

  void loadProto(String feedName, Uint8List content) async {
    await _loader.loadFromBytes(feedName, content);
  }

  Future<Stop?> getStopByCode(String feedName, String stopCode) =>
      queries.stops.getByCode(feedName, stopCode);

  Future<List<Stop>> autocompleteStops(String query) async {
    return []; // TODO
  }

  Future<List<Stop>> findStopsAround(LatLng center, double radiusMeters) =>
      queries.stops.findForHashes(
        geohash.forCircle(
          center.latitude,
          center.longitude,
          radiusMeters,
          Stop.kGeohashPrecision,
        ),
      );

  Future<List<Stop>> findStopsForBounds(LatLng southWest, LatLng northEast) =>
      queries.stops.findForHashes(
        geohash.forBounds(
          southWest.latitude,
          southWest.longitude,
          northEast.latitude,
          northEast.longitude,
          Stop.kGeohashPrecision,
        ),
      );

  Future<List<Arrival>> findArrivals({
    required FeedId stopId,
    DateTime? now,
    List<FeedId>?
    serviceIds, // TODO: keep in the database to rid the user of storing
    int beforeSeconds = 0,
    int afterSeconds = 3600,
  }) async {
    now ??= DateTime.now();
    serviceIds ??= await queries.services.queryByDate(JustDate.fromDateTime(now));
    final time = JustTime.fromDateTime(now).toInt();

    // 1. Query all trips that _might_ fit based on the date and the stop and the time.
    final db = await _database.database;
    final placeholders = List.generate(serviceIds.length, (i) => '?').join(',');
    final results = await db.rawQuery(
      'select * from ${ItineraryStopRef.kTable.name} left join ${Trip.kTable.name} using (feed_id, itinerary_id) '
      'where feed_id = ? and stop_id = ? and service_id in ($placeholders) and first_arrival <= ? and last_departure >= ?',
      [
        stopId.feedId,
        stopId.id,
        ...serviceIds.map((s) => s.id),
        time - beforeSeconds,
        time + afterSeconds,
      ],
    );

    // 2. Now filter trips that definitely fit.
    final trips = results.map((row) => Trip.fromJson(row));
    final sequenceIds = {
      for (final row in results) row['trip_id']: row['sequence'],
    };
    // TODO: different algorithms for schedule-based and frequency-based!

    // 3. Fetch the full data for those trips and build the arrivals.
    final itineraryIds = trips.map((t) => t.itineraryId).toSet();
    final placeholders2 = List.generate(
      itineraryIds.length,
      (i) => '?',
    ).join(',');
    final results2 = await db.rawQuery(
      'select * from ${Itinerary.kTable.name} '
      'left join ${Shape.kTable.name} using (feed_id, shape_id) '
      'left join ${Route.kTable.name} using (feed_id, route_id) '
      'where itinerary_id in ($placeholders2)',
      [...itineraryIds],
    ); // TODO?
    return []; // TODO
  }

  Future<SpecificTrip> getSpecificTrip(SpecificTripId id) async {
    throw UnimplementedError("TODO");
  }

  Future<List<Itinerary>> getItinerariesForStop(FeedId stopId) async {
    final db = await _database.database;
    final result = await db.rawQuery(
      'select i.* from ${ItineraryStopRef.kTable.name} isr '
      'left join ${Itinerary.kTable.name} i using (feed_id, itinerary_id) '
      'where isr.feed_id = ? and isr.stop_id = ?',
      [stopId.feedId, stopId.id],
    );
    return result.map((row) => Itinerary.fromJson(row)).toList();
  }

  Future<Set<Route>> getRoutesForStop(FeedId stopId) async {
    final db = await _database.database;
    final result = await db.rawQuery(
      'select i.* from ${ItineraryStopRef.kTable.name} isr '
      'left join ${Itinerary.kTable.name} i using (feed_id, itinerary_id) '
      'left join ${Route.kTable.name} r using (feed_id, route_id) '
      'where isr.feed_id = ? and isr.stop_id = ?',
      [stopId.feedId, stopId.id],
    );
    return result.map((row) => Route.fromJson(row)).toSet();
  }

  Future<List<JustTime>> findArrivalsForDay(
    FeedId routeId,
    FeedId stopId,
    JustDate date,
  ) async {
    return []; // TODO
  }
}
