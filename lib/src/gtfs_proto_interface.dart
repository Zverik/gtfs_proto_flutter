import 'dart:typed_data';

import 'package:fast_geohash/fast_geohash_str.dart';
import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/helpers/just_date.dart';
import 'package:gtfs_proto_flutter/src/helpers/schedule_item.dart';
import 'package:gtfs_proto_flutter/src/loader.dart';
import 'package:gtfs_proto_flutter/src/models.dart';
import 'package:gtfs_proto_flutter/src/queries.dart';
import 'package:latlong2/latlong.dart';

class GtfsProto {
  final DatabaseHelper _database;
  late final ProtoLoader _loader;
  late final Queries queries;

  GtfsProto(String databasePath) : _database = DatabaseHelper(databaseName: databasePath) {
    _loader = ProtoLoader(_database);
    queries = Queries(_database);
  }

  Future<void> loadProto(String feedName, Uint8List content, [LoaderCallback? callback]) async {
    await _loader.loadFromBytes(feedName, content, callback);
  }

  Future<Stop?> getStopByCode(String feedName, String stopCode) => queries.stops.getByCode(feedName, stopCode);

  Future<List<Stop>> autocompleteStops(String query) async {
    return []; // TODO
  }

  Future<List<Stop>> findStopsAround(LatLng center, double radiusMeters) => queries.stops.findForHashes(
    geohash.forCircle(center.latitude, center.longitude, radiusMeters, Stop.kGeohashPrecision),
  );

  Future<List<Stop>> findStopsForBounds(LatLng southWest, LatLng northEast) => queries.stops.findForHashes(
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
    int pastSeconds = 0,
    int futureSeconds = 3600,
  }) async {
    return await queries.arrivals.findArrivals(
      stopId: stopId,
      now: now,
      pastSeconds: pastSeconds,
      futureSeconds: futureSeconds,
    );
  }

  Future<SpecificTrip?> getSpecificTrip(SpecificTripId id) async {
    return await queries.arrivals.getSpecificTrip(id);
  }

  Future<List<Itinerary>> getItinerariesForStop(FeedId stopId) async {
    return await queries.itineraries.getForStops([stopId]);
  }

  Future<Set<Route>> getRoutesForStop(FeedId stopId) async {
    return await queries.routes.getForStop(stopId);
  }

  Future<List<ScheduleItem>> findArrivalsForDay(FeedId routeId, FeedId stopId, JustDate date) async {
    return []; // TODO
  }
}
