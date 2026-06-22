import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/models/itinerary.dart';
import 'package:gtfs_proto_flutter/src/models/stop.dart';
import 'package:gtfs_proto_flutter/src/models/route.dart';
import 'package:latlong2/latlong.dart';

class TripStop {
  final Stop stop;
  final String headsign;
  final DateTime arrival;
  final DateTime departure;
  final PickupDropoff pickup;
  final PickupDropoff dropoff;

  TripStop({
    required this.stop,
    required this.headsign,
    required this.arrival,
    required this.departure,
    required this.pickup,
    required this.dropoff,
  });
}

class SpecificTripId {
  final FeedId tripId;
  final DateTime firstDeparture;
  final bool approximate;

  SpecificTripId({
    required this.tripId,
    required this.firstDeparture,
    required this.approximate,
  });
}

class SpecificTrip {
  final FeedId tripId;
  final Route route;
  final List<LatLng>? shape;
  final String? name;
  final List<TripStop> stops;
  final Accessibility wheelchair;
  final Accessibility bikes;
  bool approximate;
  final int? frequencySeconds;

  SpecificTrip({
    required this.tripId,
    required this.route,
    this.shape,
    this.name,
    required this.stops,
    this.wheelchair = Accessibility.unknown,
    this.bikes = Accessibility.unknown,
    this.approximate = false,
    this.frequencySeconds,
  });

  SpecificTripId get id => SpecificTripId(
    tripId: tripId,
    approximate: approximate,
    firstDeparture: stops.first.departure,
  );
}

class Arrival {
  final SpecificTrip trip;
  final TripStop stop;

  Arrival(this.trip, int stopId)
    : stop = trip.stops.firstWhere((s) => s.stop.id.id == stopId);
}
