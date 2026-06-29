//
//  Generated code. Do not modify.
//  source: gtfs.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class LocationType extends $pb.ProtobufEnum {
  static const LocationType L_STOP = LocationType._(0, _omitEnumNames ? '' : 'L_STOP');
  static const LocationType L_STATION = LocationType._(1, _omitEnumNames ? '' : 'L_STATION');
  static const LocationType L_EXIT = LocationType._(2, _omitEnumNames ? '' : 'L_EXIT');
  static const LocationType L_NODE = LocationType._(3, _omitEnumNames ? '' : 'L_NODE');
  static const LocationType L_BOARDING = LocationType._(4, _omitEnumNames ? '' : 'L_BOARDING');

  static const $core.List<LocationType> values = <LocationType> [
    L_STOP,
    L_STATION,
    L_EXIT,
    L_NODE,
    L_BOARDING,
  ];

  static final $core.Map<$core.int, LocationType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static LocationType? valueOf($core.int value) => _byValue[value];

  const LocationType._($core.int v, $core.String n) : super(v, n);
}

class Accessibility extends $pb.ProtobufEnum {
  static const Accessibility A_UNKNOWN = Accessibility._(0, _omitEnumNames ? '' : 'A_UNKNOWN');
  static const Accessibility A_SOME = Accessibility._(1, _omitEnumNames ? '' : 'A_SOME');
  static const Accessibility A_NO = Accessibility._(2, _omitEnumNames ? '' : 'A_NO');

  static const $core.List<Accessibility> values = <Accessibility> [
    A_UNKNOWN,
    A_SOME,
    A_NO,
  ];

  static final $core.Map<$core.int, Accessibility> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Accessibility? valueOf($core.int value) => _byValue[value];

  const Accessibility._($core.int v, $core.String n) : super(v, n);
}

/// See also https://developers.google.com/transit/gtfs/reference/extended-route-types
class RouteType extends $pb.ProtobufEnum {
  static const RouteType T_BUS = RouteType._(0, _omitEnumNames ? '' : 'T_BUS');
  static const RouteType T_TRAM = RouteType._(1, _omitEnumNames ? '' : 'T_TRAM');
  static const RouteType T_SUBWAY = RouteType._(2, _omitEnumNames ? '' : 'T_SUBWAY');
  static const RouteType T_RAIL = RouteType._(3, _omitEnumNames ? '' : 'T_RAIL');
  static const RouteType T_FERRY = RouteType._(4, _omitEnumNames ? '' : 'T_FERRY');
  static const RouteType T_CABLE_TRAM = RouteType._(5, _omitEnumNames ? '' : 'T_CABLE_TRAM');
  static const RouteType T_AERIAL = RouteType._(6, _omitEnumNames ? '' : 'T_AERIAL');
  static const RouteType T_FUNICULAR = RouteType._(7, _omitEnumNames ? '' : 'T_FUNICULAR');
  static const RouteType T_COMMUNAL_TAXI = RouteType._(9, _omitEnumNames ? '' : 'T_COMMUNAL_TAXI');
  static const RouteType T_COACH = RouteType._(10, _omitEnumNames ? '' : 'T_COACH');
  static const RouteType T_TROLLEYBUS = RouteType._(11, _omitEnumNames ? '' : 'T_TROLLEYBUS');
  static const RouteType T_MONORAIL = RouteType._(12, _omitEnumNames ? '' : 'T_MONORAIL');
  static const RouteType T_URBAN_RAIL = RouteType._(21, _omitEnumNames ? '' : 'T_URBAN_RAIL');
  static const RouteType T_WATER = RouteType._(22, _omitEnumNames ? '' : 'T_WATER');
  static const RouteType T_AIR = RouteType._(23, _omitEnumNames ? '' : 'T_AIR');
  static const RouteType T_TAXI = RouteType._(24, _omitEnumNames ? '' : 'T_TAXI');
  static const RouteType T_MISC = RouteType._(25, _omitEnumNames ? '' : 'T_MISC');

  static const $core.List<RouteType> values = <RouteType> [
    T_BUS,
    T_TRAM,
    T_SUBWAY,
    T_RAIL,
    T_FERRY,
    T_CABLE_TRAM,
    T_AERIAL,
    T_FUNICULAR,
    T_COMMUNAL_TAXI,
    T_COACH,
    T_TROLLEYBUS,
    T_MONORAIL,
    T_URBAN_RAIL,
    T_WATER,
    T_AIR,
    T_TAXI,
    T_MISC,
  ];

  static final $core.Map<$core.int, RouteType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RouteType? valueOf($core.int value) => _byValue[value];

  const RouteType._($core.int v, $core.String n) : super(v, n);
}

class PickupDropoff extends $pb.ProtobufEnum {
  static const PickupDropoff PD_YES = PickupDropoff._(0, _omitEnumNames ? '' : 'PD_YES');
  static const PickupDropoff PD_NO = PickupDropoff._(1, _omitEnumNames ? '' : 'PD_NO');
  static const PickupDropoff PD_PHONE_AGENCY = PickupDropoff._(2, _omitEnumNames ? '' : 'PD_PHONE_AGENCY');
  static const PickupDropoff PD_TELL_DRIVER = PickupDropoff._(3, _omitEnumNames ? '' : 'PD_TELL_DRIVER');

  static const $core.List<PickupDropoff> values = <PickupDropoff> [
    PD_YES,
    PD_NO,
    PD_PHONE_AGENCY,
    PD_TELL_DRIVER,
  ];

  static final $core.Map<$core.int, PickupDropoff> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PickupDropoff? valueOf($core.int value) => _byValue[value];

  const PickupDropoff._($core.int v, $core.String n) : super(v, n);
}

class TransferType extends $pb.ProtobufEnum {
  static const TransferType TR_POSSIBLE = TransferType._(0, _omitEnumNames ? '' : 'TR_POSSIBLE');
  static const TransferType TR_DEPARTURE_WAITS = TransferType._(1, _omitEnumNames ? '' : 'TR_DEPARTURE_WAITS');
  static const TransferType TR_NEEDS_TIME = TransferType._(2, _omitEnumNames ? '' : 'TR_NEEDS_TIME');
  static const TransferType TR_NOT_POSSIBLE = TransferType._(3, _omitEnumNames ? '' : 'TR_NOT_POSSIBLE');
  static const TransferType TR_IN_SEAT = TransferType._(4, _omitEnumNames ? '' : 'TR_IN_SEAT');
  static const TransferType TR_IN_SEAT_FORBIDDEN = TransferType._(5, _omitEnumNames ? '' : 'TR_IN_SEAT_FORBIDDEN');

  static const $core.List<TransferType> values = <TransferType> [
    TR_POSSIBLE,
    TR_DEPARTURE_WAITS,
    TR_NEEDS_TIME,
    TR_NOT_POSSIBLE,
    TR_IN_SEAT,
    TR_IN_SEAT_FORBIDDEN,
  ];

  static final $core.Map<$core.int, TransferType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TransferType? valueOf($core.int value) => _byValue[value];

  const TransferType._($core.int v, $core.String n) : super(v, n);
}

/// These go in the file order.
/// Sorted so that you don't need random access, but can process file top to bottom.
class Block extends $pb.ProtobufEnum {
  static const Block B_HEADER = Block._(0, _omitEnumNames ? '' : 'B_HEADER');
  static const Block B_IDS = Block._(1, _omitEnumNames ? '' : 'B_IDS');
  static const Block B_STRINGS = Block._(2, _omitEnumNames ? '' : 'B_STRINGS');
  static const Block B_AGENCY = Block._(3, _omitEnumNames ? '' : 'B_AGENCY');
  static const Block B_SERVICES = Block._(4, _omitEnumNames ? '' : 'B_SERVICES');
  static const Block B_SHAPES = Block._(5, _omitEnumNames ? '' : 'B_SHAPES');
  static const Block B_STOPS = Block._(6, _omitEnumNames ? '' : 'B_STOPS');
  static const Block B_ROUTES = Block._(7, _omitEnumNames ? '' : 'B_ROUTES');
  static const Block B_ITINERARIES = Block._(8, _omitEnumNames ? '' : 'B_ITINERARIES');
  static const Block B_TRIPS = Block._(9, _omitEnumNames ? '' : 'B_TRIPS');
  static const Block B_TRANSFERS = Block._(10, _omitEnumNames ? '' : 'B_TRANSFERS');
  static const Block B_NETWORKS = Block._(11, _omitEnumNames ? '' : 'B_NETWORKS');
  static const Block B_AREAS = Block._(12, _omitEnumNames ? '' : 'B_AREAS');
  static const Block B_END = Block._(49, _omitEnumNames ? '' : 'B_END');
  static const Block B_ZONES = Block._(50, _omitEnumNames ? '' : 'B_ZONES');

  static const $core.List<Block> values = <Block> [
    B_HEADER,
    B_IDS,
    B_STRINGS,
    B_AGENCY,
    B_SERVICES,
    B_SHAPES,
    B_STOPS,
    B_ROUTES,
    B_ITINERARIES,
    B_TRIPS,
    B_TRANSFERS,
    B_NETWORKS,
    B_AREAS,
    B_END,
    B_ZONES,
  ];

  static final $core.Map<$core.int, Block> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Block? valueOf($core.int value) => _byValue[value];

  const Block._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
