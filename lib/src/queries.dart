import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/queries/feed.dart';
import 'package:gtfs_proto_flutter/src/queries/route.dart';
import 'package:gtfs_proto_flutter/src/queries/stop.dart';
import 'package:gtfs_proto_flutter/src/queries/trip.dart';

class Queries {
  final FeedQueries feeds;
  final StopQueries stops;
  final RouteQueries routes;
  final TripQueries trips;

  Queries(DatabaseHelper database)
    : feeds = FeedQueries(database),
      stops = StopQueries(database),
      routes = RouteQueries(database),
      trips = TripQueries(database);
}
