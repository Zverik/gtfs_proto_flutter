import 'dart:math' show max;

import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/database/table_metadata.dart';
import 'package:gtfs_proto_flutter/src/helpers/just_time.dart';
import 'package:gtfs_proto_flutter/src/models/arrival.dart';
import 'package:gtfs_proto_flutter/src/models/stop.dart';

class Trip {
  final FeedId id;
  final String originalId;
  final int itineraryId;
  final int serviceId;
  final String? name;
  final Accessibility wheelchair;
  final Accessibility bikes;
  bool approximate;
  final List<JustTime> departures;
  final List<JustTime> arrivals;
  final JustTime? startTime;
  final JustTime? endTime;
  final int? interval;

  Trip({
    required this.id,
    required this.originalId,
    required this.itineraryId,
    required this.serviceId,
    this.name,
    this.wheelchair = Accessibility.unknown,
    this.bikes = Accessibility.unknown,
    this.approximate = false,
    required this.departures,
    this.arrivals = const [],
    this.startTime,
    this.endTime,
    this.interval,
  });

  SpecificTripId specificTrip({
    required DateTime departure,
    int sequence = 0,
    bool liveDeparture = false,
  }) {
    // TODO: we know the exact time of departure for [sequence], need to get the first one.
    return SpecificTripId(
      tripId: id,
      firstDeparture: departure,
      approximate: !liveDeparture,
    );
  }

  static const kTable = TableMetadata(
    name: 'trips',
    key: 'trip_id',
    columns: [
      'gtfs_trip_id text',
      'itinerary_id integer',
      'service_id integer',
      'trip_name text',
      'wheelchair integer',
      'bikes integer',
      'approximate integer',
      'departures text',
      'arrivals text',
      'start_time integer',
      'end_time integer',
      'interval integer',
      'first_arrival integer',
      'last_departure integer',
    ],
    indexes: [
      'feed_id, itinerary_id, service_id, first_arrival, last_departure',
    ],
  );

  factory Trip.fromJson(Map<String, dynamic> data) => Trip(
    id: kTable.readId(data),
    originalId: data['gtfs_trip_id'],
    itineraryId: data['itinerary_id'],
    serviceId: data['service_id'],
    name: data['trip_name'],
    wheelchair: Accessibility.values[data['wheelchair'] ?? 0],
    bikes: Accessibility.values[data['bikes'] ?? 0],
    approximate: data['approximate'] == 1,
    departures: (data['departures'] as String ?? '')
        .split(',')
        .where((s) => s.isNotEmpty)
        .map((s) => JustTime.fromInt(int.parse(s)))
        .toList(),
    arrivals: (data['arrivals'] as String ?? '')
        .split(',')
        .where((s) => s.isNotEmpty)
        .map((s) => JustTime.fromInt(int.parse(s)))
        .toList(),
    startTime: data['start_time'] == null
        ? null
        : JustTime.fromInt(data['start_time']),
    endTime: data['end_time'] == null
        ? null
        : JustTime.fromInt(data['end_time']),
    interval: int.tryParse(data['interval'] ?? ''),
  );

  JustTime _getFirstArrival() =>
      startTime ?? arrivals.firstOrNull ?? departures.first;

  JustTime _getLastDeparture() {
    if (endTime == null) return departures.lastOrNull ?? arrivals.last;
    // endTime is the time of the first arrival.
    int arrivalDelta = arrivals.length < 2
        ? 0
        : arrivals.last.toInt() - arrivals.first.toInt();
    int depDelta = departures.length < 2
        ? 0
        : departures.last.toInt() -
              (arrivals.firstOrNull?.toInt() ?? departures.first.toInt());
    return JustTime.fromInt(endTime!.toInt() + max(arrivalDelta, depDelta));
  }

  Map<String, dynamic> toJson() => {
    ...kTable.writeId(id),
    'gtfs_trip_id': originalId,
    'itinerary_id': itineraryId,
    'service_id': serviceId,
    'trip_name': name,
    'wheelchair': wheelchair.index,
    'bikes': bikes.index,
    'approximate': approximate ? 1 : 0,
    'departures': departures.map((d) => d.toInt()).join(','),
    'arrivals': arrivals.map((d) => d.toInt()).join(','),
    'start_time': startTime?.toInt(),
    'end_time': endTime?.toInt(),
    'interval': interval,
    'first_arrival': _getFirstArrival(),
    'last_departure': _getLastDeparture(),
  };

  @override
  bool operator ==(Object other) =>
      other is Trip && other.id == id && other.originalId == originalId;

  @override
  int get hashCode => Object.hash(id, originalId);
}
