import 'dart:ui' show Color;

import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/database/table_metadata.dart';
import 'package:gtfs_proto_flutter/src/helpers/null_if_empty.dart';
import 'package:gtfs_proto_flutter/src/proto/gtfs.pb.dart' as gtfs;

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
  final String gtfsId;
  final int agencyId;
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
    required this.gtfsId,
    required this.agencyId,
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
    gtfsId: data['gtfs_route_id'],
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
    'gtfs_route_id': gtfsId,
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

  static final kRouteTypeFromProto = {
    gtfs.RouteType.T_BUS: RouteType.bus,
    gtfs.RouteType.T_TRAM: RouteType.tram,
    gtfs.RouteType.T_SUBWAY: RouteType.subway,
    gtfs.RouteType.T_RAIL: RouteType.rail,
    gtfs.RouteType.T_FERRY: RouteType.ferry,
    gtfs.RouteType.T_CABLE_TRAM: RouteType.cableTram,
    gtfs.RouteType.T_AERIAL: RouteType.aerial,
    gtfs.RouteType.T_FUNICULAR: RouteType.funicular,
    gtfs.RouteType.T_COMMUNAL_TAXI: RouteType.communalTaxi,
    gtfs.RouteType.T_COACH: RouteType.coach,
    gtfs.RouteType.T_TROLLEYBUS: RouteType.trolleybus,
    gtfs.RouteType.T_MONORAIL: RouteType.monorail,
    gtfs.RouteType.T_URBAN_RAIL: RouteType.urbanRail,
    gtfs.RouteType.T_WATER: RouteType.water,
    gtfs.RouteType.T_AIR: RouteType.air,
    gtfs.RouteType.T_TAXI: RouteType.taxi,
    gtfs.RouteType.T_MISC: RouteType.misc,
  };

  static final kPickupDropoffFromProto = {
    gtfs.PickupDropoff.PD_YES: PickupDropoff.yes,
    gtfs.PickupDropoff.PD_NO: PickupDropoff.no,
    gtfs.PickupDropoff.PD_TELL_DRIVER: PickupDropoff.tellDriver,
    gtfs.PickupDropoff.PD_PHONE_AGENCY: PickupDropoff.phoneAgency,
  };

  factory Route.fromProto(
    int feedId,
    String? gtfsId,
    int? agencyId,
    List<String> strings,
    gtfs.Route proto,
    Route? old,
  ) => Route(
    id: FeedId(feedId, proto.routeId),
    gtfsId: gtfsId ?? old!.gtfsId,
    agencyId: proto.agencyId == 0 ? agencyId! : proto.agencyId,
    shortName: proto.shortName.nullIfEmpty ?? old?.shortName,
    longName: proto.longName.isNotEmpty
        ? proto.longName.map((idx) => strings[idx]).join(' — ').nullIfEmpty
        : old?.longName,
    description: proto.desc.nullIfEmpty ?? old?.description,
    routeType: kRouteTypeFromProto[proto.type]!,
    color: Color(
      0xFF000000 |
          (proto.color == 0
              ? 0xFFFFFF
              : proto.color == 0xFFFFFF
              ? 0
              : proto.color),
    ),
    textColor: Color(0xFF000000 | proto.textColor),
    continuousPickup: kPickupDropoffFromProto[proto.continuousPickup]!,
    continuousDropoff: kPickupDropoffFromProto[proto.continuousDropoff]!,
    networkId: proto.network.nullIfZero,
  );

  @override
  bool operator ==(Object other) => other is Route && other.id == id && other.gtfsId == gtfsId;

  @override
  int get hashCode => Object.hash(id, gtfsId);
}
