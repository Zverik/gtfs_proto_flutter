import 'dart:ui' show Color;

import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/database/table_metadata.dart';

enum RouteType {
  bus,
  tram,
  subway,
  rail,
  ferry,
  cableTram,
  aerial,
  funicular,
  communalTaxi,
  coach,
  trolleybus,
  monorail,
  urbanRail,
  water,
  air,
  taxi,
  misc,
}

enum PickupDropoff { yes, no, phoneAgency, tellDriver }

class Route {
  final FeedId id;
  final String originalId;
  final int? agencyId;
  final String? shortName;
  final String? longName;
  final String? description;
  final RouteType routeType;
  final Color color;
  final Color textColor;
  final PickupDropoff continuousPickup;
  final PickupDropoff continuousDropoff;
  final int? networkId;

  Route({
    required this.id,
    required this.originalId,
    this.agencyId,
    this.shortName,
    this.longName,
    this.description,
    this.routeType = RouteType.bus,
    required this.color,
    required this.textColor,
    this.continuousPickup = PickupDropoff.no,
    this.continuousDropoff = PickupDropoff.no,
    this.networkId,
  });

  /// Returns the short name or long name, if the former is missing.
  String get name => shortName ?? longName ?? id.toString();

  static const kTable = TableMetadata(
    name: 'routes',
    key: 'route_id',
    columns: [
      'gtfs_route_id text',
      'agency_id integer',
      'short_name text',
      'long_name text',
      'route_desc text',
      'route_type integer',
      'color integer',
      'text_color integer',
      'pickup integer',
      'dropoff integer',
      'network_id integer',
    ],
  );

  factory Route.fromJson(Map<String, dynamic> data) => Route(
    id: kTable.readId(data),
    originalId: data['gtfs_route_id'],
    agencyId: data['agency_id'],
    shortName: data['short_name'],
    longName: data['long_name'],
    description: data['route_desc'],
    routeType: RouteType.values[data['route_type'] ?? 0],
    color: Color(data['color']),
    textColor: Color(data['text_color']),
    continuousPickup: PickupDropoff.values[data['pickup'] ?? 1],
    continuousDropoff: PickupDropoff.values[data['dropoff'] ?? 1],
    networkId: data['network_id'],
  );

  Map<String, dynamic> toJson() => {
    ...kTable.writeId(id),
    'gtfs_route_id': originalId,
    'agency_id': agencyId,
    'short_name': shortName,
    'long_name': longName,
    'route_desc': description,
    'route_type': routeType.index,
    'color': color.toARGB32(),
    'text_color': textColor.toARGB32(),
    'pickup': continuousPickup.index,
    'dropoff': continuousDropoff.index,
    'network_id': networkId,
  };

  @override
  bool operator ==(Object other) => other is Route && other.id == id && other.originalId == originalId;

  @override
  int get hashCode => Object.hash(id, originalId);
}
