import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/queries/agency.dart';
import 'package:gtfs_proto_flutter/src/queries/feed.dart';
import 'package:gtfs_proto_flutter/src/queries/itinerary.dart';
import 'package:gtfs_proto_flutter/src/queries/route.dart';
import 'package:gtfs_proto_flutter/src/queries/service.dart';
import 'package:gtfs_proto_flutter/src/queries/shape.dart';
import 'package:gtfs_proto_flutter/src/queries/stop.dart';
import 'package:gtfs_proto_flutter/src/queries/trip.dart';

class Queries {
  final AgencyQueries agencies;
  final FeedQueries feeds;
  final ItineraryQueries itineraries;
  final RouteQueries routes;
  final ServiceQueries services;
  final ShapeQueries shapes;
  final StopQueries stops;
  final TripQueries trips;

  Queries(DatabaseHelper database)
    : feeds = FeedQueries(database),
      stops = StopQueries(database),
      routes = RouteQueries(database),
      trips = TripQueries(database),
      agencies = AgencyQueries(database),
      itineraries = ItineraryQueries(database),
      services = ServiceQueries(database),
      shapes = ShapeQueries(database);
}
