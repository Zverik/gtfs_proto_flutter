import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/models/itinerary.dart';
import 'package:gtfs_proto_flutter/src/models/shape.dart';
import 'package:gtfs_proto_flutter/src/models/trip.dart';
import 'package:gtfs_proto_flutter/src/models/stop.dart';
import 'package:gtfs_proto_flutter/src/models/route.dart';
import 'package:latlong2/latlong.dart';

class TripStop {
  final Stop stop;
  final String? headsign;
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

/// Additional data to a [tripId] to help construct the [SpecificTrip] instance.
class SpecificTripId {
  /// The trip for which the object is built.
  final FeedId tripId;

  /// The departure time for the [realTimeForStopIdx] stop. When the stop index is null,
  /// only the date is taken from this field.
  final DateTime departure;

  /// When we have live data for a stop, its index in the itinerary is stored here.
  final int? realTimeForStopIdx;

  SpecificTripId({required this.tripId, required this.departure, this.realTimeForStopIdx});
}

/// Contains unwrapped objects referring to a specific trip.
class SpecificTrip {
  final FeedId tripId;
  final Route route;
  final List<LatLng>? path;
  final String? name;
  final List<TripStop> stops;
  final Accessibility wheelchair;
  final Accessibility bikes;

  /// Mirrors the [Trip.approximate] flag: either it's a frequency-based trip, or
  /// some of the stop times are approximate (not timepoints). In this regard, this
  /// flag is mostly useless.
  bool approximate;

  /// If not null, departure and arrival times in [stops] should be disregarded, and
  /// this interval should be used instead for every stop.
  final int? frequencySeconds;

  /// When the object is updated with a real-time arrival, [frequencySeconds] is cleared,
  /// stop times are updated, and this field reflects the stop the calculations were made on.
  /// See [applyRealTimeArrival] for the method that does this.
  final int? realTimeStopIdx;

  SpecificTrip({
    required this.tripId,
    required this.route,
    this.path,
    this.name,
    required this.stops,
    this.wheelchair = Accessibility.unknown,
    this.bikes = Accessibility.unknown,
    this.approximate = false,
    this.frequencySeconds,
    this.realTimeStopIdx,
  });

  /// Return the identifier to reconstruct this object later from the database.
  SpecificTripId get id => SpecificTripId(
    tripId: tripId,
    departure: stops[realTimeStopIdx ?? 0].departure,
    realTimeForStopIdx: realTimeStopIdx,
  );

  /// Takes the GTFS-sourced trip and adjusts arrivals and departures, so that the specific stop
  /// has the stated arrival time.
  SpecificTrip applyRealTimeArrival(int stopId, DateTime time) {
    return this; // TODO
  }
}

/// A [SpecificTrip] wrapper highlighting one specific stop.
class Arrival {
  final SpecificTrip trip;
  final TripStop stop;

  Arrival(this.trip, int stopId) : stop = trip.stops.firstWhere((s) => s.stop.id.id == stopId);
}

extension TripToSpecific on Trip {
  SpecificTrip toSpecificTrip({
    required Route route,
    required Itinerary itinerary,
    required Map<FeedId, Stop> stops,
    Shape? shape,
    required DateTime date,
  }) {
    return SpecificTrip(
      tripId: id,
      route: route,
      path: shape?.path,
      name: name,
      stops: itinerary.stops.indexed.map((stop) => TripStop(
        stop: stops[FeedId(id.feedId, stop.$2.stopId)]!,
        headsign: stop.$2.headsign,
        // TODO: can be null, need to process it.
        arrival: arrivals[stop.$1]!.toDateTime(date),
        departure: departures[stop.$1]!.toDateTime(date),
        pickup: stop.$2.pickup,
        dropoff: stop.$2.dropoff,
      )).toList(),
      wheelchair: wheelchair,
      bikes: bikes,
      approximate: approximate,
      frequencySeconds: approximate ? interval : null,
    );
  }
}
