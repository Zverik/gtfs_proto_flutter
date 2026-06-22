import 'dart:convert';

import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/database/table_metadata.dart';
import 'package:gtfs_proto_flutter/src/models/route.dart';

class ItineraryStop {
  final int stopId;
  final String headsign;
  final PickupDropoff pickup;
  final PickupDropoff dropoff;

  ItineraryStop({
    required this.stopId,
    required this.headsign,
    required this.pickup,
    required this.dropoff,
  });

  factory ItineraryStop.fromJson(List<dynamic> data) => ItineraryStop(
    stopId: data[0],
    headsign: data[1],
    pickup: PickupDropoff.values[data[2] ?? 0],
    dropoff: PickupDropoff.values[data[3] ?? 0],
  );

  List<dynamic> toJson() => [stopId, headsign, pickup.index, dropoff.index];
}

class Itinerary {
  final FeedId id;
  final int routeId;
  final int? shapeId;
  final bool oppositeDirection;
  final List<ItineraryStop> stops;

  Itinerary({
    required this.id,
    required this.routeId,
    this.shapeId,
    this.oppositeDirection = false,
    required this.stops,
  });

  static const kTable = TableMetadata(
    name: 'itineraries',
    key: 'itinerary_id',
    columns: [
      'route_id integer',
      'shape_id integer',
      'opposite integer',
      'stops text',
    ],
  );

  factory Itinerary.fromJson(Map<String, dynamic> data) => Itinerary(
    id: kTable.readId(data),
    routeId: data['route_id'],
    shapeId: data['shape_id'],
    oppositeDirection: data['opposite'] == 1,
    stops: (json.decode(data['stops']) as List<dynamic>)
        .map((s) => ItineraryStop.fromJson(s))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    ...kTable.writeId(id),
    'route_id': routeId,
    'shape_id': shapeId,
    'opposite': oppositeDirection ? 1 : 0,
    'stops': json.encode(stops.map((s) => s.toJson()).toList()),
  };

  Iterable<ItineraryStopRef> toStopRefs() => List.generate(
    stops.length,
    (i) => ItineraryStopRef(
      feedId: id.feedId,
      itineraryId: id.id,
      sequence: i,
      stopId: stops[i].stopId,
    ),
  );

  @override
  bool operator ==(Object other) =>
      other is Itinerary && other.id == id && other.routeId == routeId;

  @override
  int get hashCode => Object.hash(id, routeId);
}

class ItineraryStopRef {
  final int feedId;
  final int stopId;
  final int itineraryId;
  final int sequence;

  ItineraryStopRef({
    required this.feedId,
    required this.stopId,
    required this.itineraryId,
    required this.sequence,
  });

  static const kTable = TableMetadata(
    name: 'itinerary_stops',
    columns: [
      'feed_id integer',
      'itinerary_id integer',
      'stop_id integer',
      'sequence integer',
    ],
    indexes: ['feed_id, stop_id'],
    isManyToMany: true,
  );

  factory ItineraryStopRef.fromJson(Map<String, dynamic> data) =>
      ItineraryStopRef(
        feedId: data['feed_id'],
        stopId: data['stop_id'],
        itineraryId: data['itinerary_id'],
        sequence: data['sequence'],
      );

  Map<String, dynamic> toJson() => {
    'feed_id': feedId,
    'stop_id': stopId,
    'itinerary_id': itineraryId,
    'sequence': sequence,
  };
}
