import 'package:gtfs_proto_flutter/src/helpers/just_time.dart';
import 'package:gtfs_proto_flutter/src/models/itinerary.dart';
import 'package:gtfs_proto_flutter/src/models/route.dart';
import 'package:gtfs_proto_flutter/src/models/stop.dart';
import 'package:gtfs_proto_flutter/src/models/trip.dart';

/// A line in the day schedule for a route. Can have only one of the fields:
/// either [departure] with a fixed departure time, or [frequency] with an interval for a time range.
///
/// It also contains some stop and trip attributes from respective objects.
class ScheduleItem implements Comparable<ScheduleItem> {
  final JustTime? departure;
  final Frequency? frequency;

  final PickupDropoff pickup;
  final PickupDropoff dropoff;
  final Accessibility wheelchair;
  final Accessibility bikes;

  ScheduleItem({
    this.departure,
    this.frequency,
    required this.pickup,
    required this.dropoff,
    required this.wheelchair,
    required this.bikes,
  });

  factory ScheduleItem.frequencyFromTrip(ItineraryStop stop, Trip trip) => ScheduleItem(
    frequency: Frequency.fromTrip(trip),
    pickup: stop.pickup,
    dropoff: stop.dropoff,
    wheelchair: trip.wheelchair,
    bikes: trip.bikes,
  );

  factory ScheduleItem.departureFromTrip(JustTime departure, ItineraryStop stop, Trip trip) => ScheduleItem(
    departure: departure,
    pickup: stop.pickup,
    dropoff: stop.dropoff,
    wheelchair: trip.wheelchair,
    bikes: trip.bikes,
  );

  @override
  int compareTo(ScheduleItem other) =>
      (departure ?? frequency!.start).compareTo(other.departure ?? other.frequency!.start);

  @override
  String toString() =>
      'ScheduleItem(${departure ?? frequency}, p=${pickup.name}, d=${dropoff.name}, w=${wheelchair.name}, b=${bikes.name})';
}

/// A time range and an interval for a frequency-based trip. Mirrors the same
/// three fields from the [Trip] class.
class Frequency {
  final JustTime start;
  final JustTime end;
  final int intervalSec;

  Frequency(this.start, this.end, this.intervalSec);

  factory Frequency.fromTrip(Trip trip) => Frequency(trip.startTime!, trip.endTime!, trip.interval!);

  @override
  bool operator ==(Object other) =>
      other is Frequency && other.start == start && other.end == end && other.intervalSec == intervalSec;

  @override
  int get hashCode => Object.hash(start, end, intervalSec);

  @override
  String toString() => 'Frequency($start, $end, $intervalSec)';
}
