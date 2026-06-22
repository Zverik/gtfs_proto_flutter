// This is a generated file - do not edit.
//
// Generated from gtfs.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use locationTypeDescriptor instead')
const LocationType$json = {
  '1': 'LocationType',
  '2': [
    {'1': 'L_STOP', '2': 0},
    {'1': 'L_STATION', '2': 1},
    {'1': 'L_EXIT', '2': 2},
    {'1': 'L_NODE', '2': 3},
    {'1': 'L_BOARDING', '2': 4},
  ],
};

/// Descriptor for `LocationType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List locationTypeDescriptor = $convert.base64Decode(
    'CgxMb2NhdGlvblR5cGUSCgoGTF9TVE9QEAASDQoJTF9TVEFUSU9OEAESCgoGTF9FWElUEAISCg'
    'oGTF9OT0RFEAMSDgoKTF9CT0FSRElORxAE');

@$core.Deprecated('Use accessibilityDescriptor instead')
const Accessibility$json = {
  '1': 'Accessibility',
  '2': [
    {'1': 'A_UNKNOWN', '2': 0},
    {'1': 'A_SOME', '2': 1},
    {'1': 'A_NO', '2': 2},
  ],
};

/// Descriptor for `Accessibility`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List accessibilityDescriptor = $convert.base64Decode(
    'Cg1BY2Nlc3NpYmlsaXR5Eg0KCUFfVU5LTk9XThAAEgoKBkFfU09NRRABEggKBEFfTk8QAg==');

@$core.Deprecated('Use routeTypeDescriptor instead')
const RouteType$json = {
  '1': 'RouteType',
  '2': [
    {'1': 'T_BUS', '2': 0},
    {'1': 'T_TRAM', '2': 1},
    {'1': 'T_SUBWAY', '2': 2},
    {'1': 'T_RAIL', '2': 3},
    {'1': 'T_FERRY', '2': 4},
    {'1': 'T_CABLE_TRAM', '2': 5},
    {'1': 'T_AERIAL', '2': 6},
    {'1': 'T_FUNICULAR', '2': 7},
    {'1': 'T_COMMUNAL_TAXI', '2': 9},
    {'1': 'T_COACH', '2': 10},
    {'1': 'T_TROLLEYBUS', '2': 11},
    {'1': 'T_MONORAIL', '2': 12},
    {'1': 'T_URBAN_RAIL', '2': 21},
    {'1': 'T_WATER', '2': 22},
    {'1': 'T_AIR', '2': 23},
    {'1': 'T_TAXI', '2': 24},
    {'1': 'T_MISC', '2': 25},
  ],
};

/// Descriptor for `RouteType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List routeTypeDescriptor = $convert.base64Decode(
    'CglSb3V0ZVR5cGUSCQoFVF9CVVMQABIKCgZUX1RSQU0QARIMCghUX1NVQldBWRACEgoKBlRfUk'
    'FJTBADEgsKB1RfRkVSUlkQBBIQCgxUX0NBQkxFX1RSQU0QBRIMCghUX0FFUklBTBAGEg8KC1Rf'
    'RlVOSUNVTEFSEAcSEwoPVF9DT01NVU5BTF9UQVhJEAkSCwoHVF9DT0FDSBAKEhAKDFRfVFJPTE'
    'xFWUJVUxALEg4KClRfTU9OT1JBSUwQDBIQCgxUX1VSQkFOX1JBSUwQFRILCgdUX1dBVEVSEBYS'
    'CQoFVF9BSVIQFxIKCgZUX1RBWEkQGBIKCgZUX01JU0MQGQ==');

@$core.Deprecated('Use pickupDropoffDescriptor instead')
const PickupDropoff$json = {
  '1': 'PickupDropoff',
  '2': [
    {'1': 'PD_YES', '2': 0},
    {'1': 'PD_NO', '2': 1},
    {'1': 'PD_PHONE_AGENCY', '2': 2},
    {'1': 'PD_TELL_DRIVER', '2': 3},
  ],
};

/// Descriptor for `PickupDropoff`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List pickupDropoffDescriptor = $convert.base64Decode(
    'Cg1QaWNrdXBEcm9wb2ZmEgoKBlBEX1lFUxAAEgkKBVBEX05PEAESEwoPUERfUEhPTkVfQUdFTk'
    'NZEAISEgoOUERfVEVMTF9EUklWRVIQAw==');

@$core.Deprecated('Use transferTypeDescriptor instead')
const TransferType$json = {
  '1': 'TransferType',
  '2': [
    {'1': 'TR_POSSIBLE', '2': 0},
    {'1': 'TR_DEPARTURE_WAITS', '2': 1},
    {'1': 'TR_NEEDS_TIME', '2': 2},
    {'1': 'TR_NOT_POSSIBLE', '2': 3},
    {'1': 'TR_IN_SEAT', '2': 4},
    {'1': 'TR_IN_SEAT_FORBIDDEN', '2': 5},
  ],
};

/// Descriptor for `TransferType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List transferTypeDescriptor = $convert.base64Decode(
    'CgxUcmFuc2ZlclR5cGUSDwoLVFJfUE9TU0lCTEUQABIWChJUUl9ERVBBUlRVUkVfV0FJVFMQAR'
    'IRCg1UUl9ORUVEU19USU1FEAISEwoPVFJfTk9UX1BPU1NJQkxFEAMSDgoKVFJfSU5fU0VBVBAE'
    'EhgKFFRSX0lOX1NFQVRfRk9SQklEREVOEAU=');

@$core.Deprecated('Use blockDescriptor instead')
const Block$json = {
  '1': 'Block',
  '2': [
    {'1': 'B_HEADER', '2': 0},
    {'1': 'B_IDS', '2': 1},
    {'1': 'B_STRINGS', '2': 2},
    {'1': 'B_AGENCY', '2': 3},
    {'1': 'B_SERVICES', '2': 4},
    {'1': 'B_SHAPES', '2': 5},
    {'1': 'B_STOPS', '2': 6},
    {'1': 'B_ROUTES', '2': 7},
    {'1': 'B_ITINERARIES', '2': 8},
    {'1': 'B_TRIPS', '2': 9},
    {'1': 'B_TRANSFERS', '2': 10},
    {'1': 'B_NETWORKS', '2': 11},
    {'1': 'B_AREAS', '2': 12},
    {'1': 'B_END', '2': 49},
    {'1': 'B_ZONES', '2': 50},
  ],
};

/// Descriptor for `Block`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List blockDescriptor = $convert.base64Decode(
    'CgVCbG9jaxIMCghCX0hFQURFUhAAEgkKBUJfSURTEAESDQoJQl9TVFJJTkdTEAISDAoIQl9BR0'
    'VOQ1kQAxIOCgpCX1NFUlZJQ0VTEAQSDAoIQl9TSEFQRVMQBRILCgdCX1NUT1BTEAYSDAoIQl9S'
    'T1VURVMQBxIRCg1CX0lUSU5FUkFSSUVTEAgSCwoHQl9UUklQUxAJEg8KC0JfVFJBTlNGRVJTEA'
    'oSDgoKQl9ORVRXT1JLUxALEgsKB0JfQVJFQVMQDBIJCgVCX0VORBAxEgsKB0JfWk9ORVMQMg==');

@$core.Deprecated('Use gtfsHeaderDescriptor instead')
const GtfsHeader$json = {
  '1': 'GtfsHeader',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 13, '10': 'version'},
    {'1': 'date', '3': 2, '4': 1, '5': 13, '10': 'date'},
    {'1': 'original_url', '3': 3, '4': 1, '5': 9, '10': 'originalUrl'},
    {'1': 'compressed', '3': 4, '4': 1, '5': 8, '10': 'compressed'},
    {'1': 'blocks', '3': 5, '4': 3, '5': 13, '10': 'blocks'},
  ],
};

/// Descriptor for `GtfsHeader`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gtfsHeaderDescriptor = $convert.base64Decode(
    'CgpHdGZzSGVhZGVyEhgKB3ZlcnNpb24YASABKA1SB3ZlcnNpb24SEgoEZGF0ZRgCIAEoDVIEZG'
    'F0ZRIhCgxvcmlnaW5hbF91cmwYAyABKAlSC29yaWdpbmFsVXJsEh4KCmNvbXByZXNzZWQYBCAB'
    'KAhSCmNvbXByZXNzZWQSFgoGYmxvY2tzGAUgAygNUgZibG9ja3M=');

@$core.Deprecated('Use agenciesDescriptor instead')
const Agencies$json = {
  '1': 'Agencies',
  '2': [
    {
      '1': 'agencies',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.gtfs.Agency',
      '10': 'agencies'
    },
  ],
};

/// Descriptor for `Agencies`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List agenciesDescriptor = $convert.base64Decode(
    'CghBZ2VuY2llcxIoCghhZ2VuY2llcxgBIAMoCzIMLmd0ZnMuQWdlbmN5UghhZ2VuY2llcw==');

@$core.Deprecated('Use agencyDescriptor instead')
const Agency$json = {
  '1': 'Agency',
  '2': [
    {'1': 'agency_id', '3': 1, '4': 1, '5': 13, '10': 'agencyId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'url', '3': 3, '4': 1, '5': 9, '10': 'url'},
    {'1': 'timezone', '3': 4, '4': 1, '5': 9, '10': 'timezone'},
    {'1': 'lang', '3': 5, '4': 1, '5': 9, '10': 'lang'},
    {'1': 'phone', '3': 6, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'fare_url', '3': 7, '4': 1, '5': 9, '10': 'fareUrl'},
    {'1': 'email', '3': 8, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `Agency`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List agencyDescriptor = $convert.base64Decode(
    'CgZBZ2VuY3kSGwoJYWdlbmN5X2lkGAEgASgNUghhZ2VuY3lJZBISCgRuYW1lGAIgASgJUgRuYW'
    '1lEhAKA3VybBgDIAEoCVIDdXJsEhoKCHRpbWV6b25lGAQgASgJUgh0aW1lem9uZRISCgRsYW5n'
    'GAUgASgJUgRsYW5nEhQKBXBob25lGAYgASgJUgVwaG9uZRIZCghmYXJlX3VybBgHIAEoCVIHZm'
    'FyZVVybBIUCgVlbWFpbBgIIAEoCVIFZW1haWw=');

@$core.Deprecated('Use servicesDescriptor instead')
const Services$json = {
  '1': 'Services',
  '2': [
    {'1': 'base_date', '3': 1, '4': 1, '5': 13, '10': 'baseDate'},
    {
      '1': 'services',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.gtfs.Service',
      '10': 'services'
    },
  ],
};

/// Descriptor for `Services`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List servicesDescriptor = $convert.base64Decode(
    'CghTZXJ2aWNlcxIbCgliYXNlX2RhdGUYASABKA1SCGJhc2VEYXRlEikKCHNlcnZpY2VzGAIgAy'
    'gLMg0uZ3Rmcy5TZXJ2aWNlUghzZXJ2aWNlcw==');

@$core.Deprecated('Use serviceDescriptor instead')
const Service$json = {
  '1': 'Service',
  '2': [
    {'1': 'service_id', '3': 1, '4': 1, '5': 13, '10': 'serviceId'},
    {'1': 'start_date', '3': 2, '4': 1, '5': 13, '10': 'startDate'},
    {'1': 'end_date', '3': 3, '4': 1, '5': 13, '10': 'endDate'},
    {'1': 'weekdays', '3': 4, '4': 1, '5': 13, '10': 'weekdays'},
    {'1': 'added_days', '3': 5, '4': 3, '5': 13, '10': 'addedDays'},
    {'1': 'removed_days', '3': 6, '4': 3, '5': 13, '10': 'removedDays'},
    {'1': 'delete', '3': 7, '4': 1, '5': 8, '10': 'delete'},
  ],
};

/// Descriptor for `Service`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serviceDescriptor = $convert.base64Decode(
    'CgdTZXJ2aWNlEh0KCnNlcnZpY2VfaWQYASABKA1SCXNlcnZpY2VJZBIdCgpzdGFydF9kYXRlGA'
    'IgASgNUglzdGFydERhdGUSGQoIZW5kX2RhdGUYAyABKA1SB2VuZERhdGUSGgoId2Vla2RheXMY'
    'BCABKA1SCHdlZWtkYXlzEh0KCmFkZGVkX2RheXMYBSADKA1SCWFkZGVkRGF5cxIhCgxyZW1vdm'
    'VkX2RheXMYBiADKA1SC3JlbW92ZWREYXlzEhYKBmRlbGV0ZRgHIAEoCFIGZGVsZXRl');

@$core.Deprecated('Use shapesDescriptor instead')
const Shapes$json = {
  '1': 'Shapes',
  '2': [
    {
      '1': 'shapes',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.gtfs.Shape',
      '10': 'shapes'
    },
  ],
};

/// Descriptor for `Shapes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List shapesDescriptor = $convert.base64Decode(
    'CgZTaGFwZXMSIwoGc2hhcGVzGAEgAygLMgsuZ3Rmcy5TaGFwZVIGc2hhcGVz');

@$core.Deprecated('Use shapeDescriptor instead')
const Shape$json = {
  '1': 'Shape',
  '2': [
    {'1': 'shape_id', '3': 1, '4': 1, '5': 13, '10': 'shapeId'},
    {'1': 'longitudes', '3': 2, '4': 3, '5': 17, '10': 'longitudes'},
    {'1': 'latitudes', '3': 3, '4': 3, '5': 17, '10': 'latitudes'},
  ],
};

/// Descriptor for `Shape`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List shapeDescriptor = $convert.base64Decode(
    'CgVTaGFwZRIZCghzaGFwZV9pZBgBIAEoDVIHc2hhcGVJZBIeCgpsb25naXR1ZGVzGAIgAygRUg'
    'psb25naXR1ZGVzEhwKCWxhdGl0dWRlcxgDIAMoEVIJbGF0aXR1ZGVz');

@$core.Deprecated('Use networksDescriptor instead')
const Networks$json = {
  '1': 'Networks',
  '2': [
    {
      '1': 'networks',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.gtfs.Networks.NetworksEntry',
      '10': 'networks'
    },
  ],
  '3': [Networks_NetworksEntry$json],
};

@$core.Deprecated('Use networksDescriptor instead')
const Networks_NetworksEntry$json = {
  '1': 'NetworksEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Networks`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List networksDescriptor = $convert.base64Decode(
    'CghOZXR3b3JrcxI4CghuZXR3b3JrcxgBIAMoCzIcLmd0ZnMuTmV0d29ya3MuTmV0d29ya3NFbn'
    'RyeVIIbmV0d29ya3MaOwoNTmV0d29ya3NFbnRyeRIQCgNrZXkYASABKA1SA2tleRIUCgV2YWx1'
    'ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use areasDescriptor instead')
const Areas$json = {
  '1': 'Areas',
  '2': [
    {
      '1': 'areas',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.gtfs.Areas.AreasEntry',
      '10': 'areas'
    },
  ],
  '3': [Areas_AreasEntry$json],
};

@$core.Deprecated('Use areasDescriptor instead')
const Areas_AreasEntry$json = {
  '1': 'AreasEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Areas`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List areasDescriptor = $convert.base64Decode(
    'CgVBcmVhcxIsCgVhcmVhcxgBIAMoCzIWLmd0ZnMuQXJlYXMuQXJlYXNFbnRyeVIFYXJlYXMaOA'
    'oKQXJlYXNFbnRyeRIQCgNrZXkYASABKA1SA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use stringTableDescriptor instead')
const StringTable$json = {
  '1': 'StringTable',
  '2': [
    {'1': 'strings', '3': 1, '4': 3, '5': 9, '10': 'strings'},
  ],
};

/// Descriptor for `StringTable`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stringTableDescriptor = $convert
    .base64Decode('CgtTdHJpbmdUYWJsZRIYCgdzdHJpbmdzGAEgAygJUgdzdHJpbmdz');

@$core.Deprecated('Use stopsDescriptor instead')
const Stops$json = {
  '1': 'Stops',
  '2': [
    {'1': 'stops', '3': 1, '4': 3, '5': 11, '6': '.gtfs.Stop', '10': 'stops'},
  ],
};

/// Descriptor for `Stops`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stopsDescriptor = $convert
    .base64Decode('CgVTdG9wcxIgCgVzdG9wcxgBIAMoCzIKLmd0ZnMuU3RvcFIFc3RvcHM=');

@$core.Deprecated('Use stopDescriptor instead')
const Stop$json = {
  '1': 'Stop',
  '2': [
    {'1': 'stop_id', '3': 1, '4': 1, '5': 13, '10': 'stopId'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 3, '4': 1, '5': 13, '10': 'name'},
    {'1': 'desc', '3': 4, '4': 1, '5': 9, '10': 'desc'},
    {'1': 'lat', '3': 5, '4': 1, '5': 17, '10': 'lat'},
    {'1': 'lon', '3': 6, '4': 1, '5': 17, '10': 'lon'},
    {
      '1': 'type',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.gtfs.LocationType',
      '10': 'type'
    },
    {'1': 'parent_id', '3': 8, '4': 1, '5': 13, '10': 'parentId'},
    {
      '1': 'wheelchair',
      '3': 9,
      '4': 1,
      '5': 14,
      '6': '.gtfs.Accessibility',
      '10': 'wheelchair'
    },
    {'1': 'platform_code', '3': 10, '4': 1, '5': 9, '10': 'platformCode'},
    {'1': 'zone', '3': 11, '4': 1, '5': 13, '10': 'zone'},
    {'1': 'areas', '3': 12, '4': 3, '5': 13, '10': 'areas'},
    {'1': 'delete', '3': 13, '4': 1, '5': 8, '10': 'delete'},
  ],
};

/// Descriptor for `Stop`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stopDescriptor = $convert.base64Decode(
    'CgRTdG9wEhcKB3N0b3BfaWQYASABKA1SBnN0b3BJZBISCgRjb2RlGAIgASgJUgRjb2RlEhIKBG'
    '5hbWUYAyABKA1SBG5hbWUSEgoEZGVzYxgEIAEoCVIEZGVzYxIQCgNsYXQYBSABKBFSA2xhdBIQ'
    'CgNsb24YBiABKBFSA2xvbhImCgR0eXBlGAcgASgOMhIuZ3Rmcy5Mb2NhdGlvblR5cGVSBHR5cG'
    'USGwoJcGFyZW50X2lkGAggASgNUghwYXJlbnRJZBIzCgp3aGVlbGNoYWlyGAkgASgOMhMuZ3Rm'
    'cy5BY2Nlc3NpYmlsaXR5Ugp3aGVlbGNoYWlyEiMKDXBsYXRmb3JtX2NvZGUYCiABKAlSDHBsYX'
    'Rmb3JtQ29kZRISCgR6b25lGAsgASgNUgR6b25lEhQKBWFyZWFzGAwgAygNUgVhcmVhcxIWCgZk'
    'ZWxldGUYDSABKAhSBmRlbGV0ZQ==');

@$core.Deprecated('Use routesDescriptor instead')
const Routes$json = {
  '1': 'Routes',
  '2': [
    {
      '1': 'routes',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.gtfs.Route',
      '10': 'routes'
    },
  ],
};

/// Descriptor for `Routes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routesDescriptor = $convert.base64Decode(
    'CgZSb3V0ZXMSIwoGcm91dGVzGAEgAygLMgsuZ3Rmcy5Sb3V0ZVIGcm91dGVz');

@$core.Deprecated('Use routeDescriptor instead')
const Route$json = {
  '1': 'Route',
  '2': [
    {'1': 'route_id', '3': 1, '4': 1, '5': 13, '10': 'routeId'},
    {'1': 'agency_id', '3': 2, '4': 1, '5': 13, '10': 'agencyId'},
    {'1': 'short_name', '3': 3, '4': 1, '5': 9, '10': 'shortName'},
    {'1': 'long_name', '3': 4, '4': 3, '5': 13, '10': 'longName'},
    {'1': 'desc', '3': 5, '4': 1, '5': 9, '10': 'desc'},
    {
      '1': 'type',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.gtfs.RouteType',
      '10': 'type'
    },
    {'1': 'color', '3': 7, '4': 1, '5': 13, '10': 'color'},
    {'1': 'text_color', '3': 8, '4': 1, '5': 13, '10': 'textColor'},
    {
      '1': 'continuous_pickup',
      '3': 9,
      '4': 1,
      '5': 14,
      '6': '.gtfs.PickupDropoff',
      '10': 'continuousPickup'
    },
    {
      '1': 'continuous_dropoff',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.gtfs.PickupDropoff',
      '10': 'continuousDropoff'
    },
    {'1': 'network', '3': 11, '4': 1, '5': 13, '10': 'network'},
    {'1': 'delete', '3': 12, '4': 1, '5': 8, '10': 'delete'},
  ],
};

/// Descriptor for `Route`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routeDescriptor = $convert.base64Decode(
    'CgVSb3V0ZRIZCghyb3V0ZV9pZBgBIAEoDVIHcm91dGVJZBIbCglhZ2VuY3lfaWQYAiABKA1SCG'
    'FnZW5jeUlkEh0KCnNob3J0X25hbWUYAyABKAlSCXNob3J0TmFtZRIbCglsb25nX25hbWUYBCAD'
    'KA1SCGxvbmdOYW1lEhIKBGRlc2MYBSABKAlSBGRlc2MSIwoEdHlwZRgGIAEoDjIPLmd0ZnMuUm'
    '91dGVUeXBlUgR0eXBlEhQKBWNvbG9yGAcgASgNUgVjb2xvchIdCgp0ZXh0X2NvbG9yGAggASgN'
    'Ugl0ZXh0Q29sb3ISQAoRY29udGludW91c19waWNrdXAYCSABKA4yEy5ndGZzLlBpY2t1cERyb3'
    'BvZmZSEGNvbnRpbnVvdXNQaWNrdXASQgoSY29udGludW91c19kcm9wb2ZmGAogASgOMhMuZ3Rm'
    'cy5QaWNrdXBEcm9wb2ZmUhFjb250aW51b3VzRHJvcG9mZhIYCgduZXR3b3JrGAsgASgNUgduZX'
    'R3b3JrEhYKBmRlbGV0ZRgMIAEoCFIGZGVsZXRl');

@$core.Deprecated('Use itinerariesDescriptor instead')
const Itineraries$json = {
  '1': 'Itineraries',
  '2': [
    {
      '1': 'itineraries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.gtfs.Itinerary',
      '10': 'itineraries'
    },
  ],
};

/// Descriptor for `Itineraries`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List itinerariesDescriptor = $convert.base64Decode(
    'CgtJdGluZXJhcmllcxIxCgtpdGluZXJhcmllcxgBIAMoCzIPLmd0ZnMuSXRpbmVyYXJ5UgtpdG'
    'luZXJhcmllcw==');

@$core.Deprecated('Use itineraryDescriptor instead')
const Itinerary$json = {
  '1': 'Itinerary',
  '2': [
    {'1': 'itinerary_id', '3': 1, '4': 1, '5': 13, '10': 'itineraryId'},
    {'1': 'route_id', '3': 2, '4': 1, '5': 13, '10': 'routeId'},
    {'1': 'stops', '3': 3, '4': 3, '5': 13, '10': 'stops'},
    {
      '1': 'opposite_direction',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'oppositeDirection'
    },
    {'1': 'shape_id', '3': 5, '4': 1, '5': 13, '10': 'shapeId'},
    {'1': 'headsigns', '3': 6, '4': 3, '5': 13, '10': 'headsigns'},
    {
      '1': 'pickup_types',
      '3': 7,
      '4': 3,
      '5': 14,
      '6': '.gtfs.PickupDropoff',
      '10': 'pickupTypes'
    },
    {
      '1': 'dropoff_types',
      '3': 8,
      '4': 3,
      '5': 14,
      '6': '.gtfs.PickupDropoff',
      '10': 'dropoffTypes'
    },
  ],
};

/// Descriptor for `Itinerary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List itineraryDescriptor = $convert.base64Decode(
    'CglJdGluZXJhcnkSIQoMaXRpbmVyYXJ5X2lkGAEgASgNUgtpdGluZXJhcnlJZBIZCghyb3V0ZV'
    '9pZBgCIAEoDVIHcm91dGVJZBIUCgVzdG9wcxgDIAMoDVIFc3RvcHMSLQoSb3Bwb3NpdGVfZGly'
    'ZWN0aW9uGAQgASgIUhFvcHBvc2l0ZURpcmVjdGlvbhIZCghzaGFwZV9pZBgFIAEoDVIHc2hhcG'
    'VJZBIcCgloZWFkc2lnbnMYBiADKA1SCWhlYWRzaWducxI2CgxwaWNrdXBfdHlwZXMYByADKA4y'
    'Ey5ndGZzLlBpY2t1cERyb3BvZmZSC3BpY2t1cFR5cGVzEjgKDWRyb3BvZmZfdHlwZXMYCCADKA'
    '4yEy5ndGZzLlBpY2t1cERyb3BvZmZSDGRyb3BvZmZUeXBlcw==');

@$core.Deprecated('Use tripsDescriptor instead')
const Trips$json = {
  '1': 'Trips',
  '2': [
    {'1': 'trips', '3': 1, '4': 3, '5': 11, '6': '.gtfs.Trip', '10': 'trips'},
  ],
};

/// Descriptor for `Trips`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tripsDescriptor = $convert
    .base64Decode('CgVUcmlwcxIgCgV0cmlwcxgBIAMoCzIKLmd0ZnMuVHJpcFIFdHJpcHM=');

@$core.Deprecated('Use tripDescriptor instead')
const Trip$json = {
  '1': 'Trip',
  '2': [
    {'1': 'trip_id', '3': 1, '4': 1, '5': 13, '10': 'tripId'},
    {'1': 'itinerary_id', '3': 2, '4': 1, '5': 13, '10': 'itineraryId'},
    {'1': 'service_id', '3': 3, '4': 1, '5': 13, '10': 'serviceId'},
    {'1': 'short_name', '3': 4, '4': 1, '5': 9, '10': 'shortName'},
    {
      '1': 'wheelchair',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.gtfs.Accessibility',
      '10': 'wheelchair'
    },
    {
      '1': 'bikes',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.gtfs.Accessibility',
      '10': 'bikes'
    },
    {'1': 'approximate', '3': 7, '4': 1, '5': 8, '10': 'approximate'},
    {'1': 'departures', '3': 8, '4': 3, '5': 13, '10': 'departures'},
    {'1': 'arrivals', '3': 9, '4': 3, '5': 13, '10': 'arrivals'},
    {'1': 'start_time', '3': 10, '4': 1, '5': 13, '10': 'startTime'},
    {'1': 'end_time', '3': 11, '4': 1, '5': 13, '10': 'endTime'},
    {'1': 'interval', '3': 12, '4': 1, '5': 13, '10': 'interval'},
  ],
};

/// Descriptor for `Trip`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tripDescriptor = $convert.base64Decode(
    'CgRUcmlwEhcKB3RyaXBfaWQYASABKA1SBnRyaXBJZBIhCgxpdGluZXJhcnlfaWQYAiABKA1SC2'
    'l0aW5lcmFyeUlkEh0KCnNlcnZpY2VfaWQYAyABKA1SCXNlcnZpY2VJZBIdCgpzaG9ydF9uYW1l'
    'GAQgASgJUglzaG9ydE5hbWUSMwoKd2hlZWxjaGFpchgFIAEoDjITLmd0ZnMuQWNjZXNzaWJpbG'
    'l0eVIKd2hlZWxjaGFpchIpCgViaWtlcxgGIAEoDjITLmd0ZnMuQWNjZXNzaWJpbGl0eVIFYmlr'
    'ZXMSIAoLYXBwcm94aW1hdGUYByABKAhSC2FwcHJveGltYXRlEh4KCmRlcGFydHVyZXMYCCADKA'
    '1SCmRlcGFydHVyZXMSGgoIYXJyaXZhbHMYCSADKA1SCGFycml2YWxzEh0KCnN0YXJ0X3RpbWUY'
    'CiABKA1SCXN0YXJ0VGltZRIZCghlbmRfdGltZRgLIAEoDVIHZW5kVGltZRIaCghpbnRlcnZhbB'
    'gMIAEoDVIIaW50ZXJ2YWw=');

@$core.Deprecated('Use transfersDescriptor instead')
const Transfers$json = {
  '1': 'Transfers',
  '2': [
    {
      '1': 'transfers',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.gtfs.Transfer',
      '10': 'transfers'
    },
  ],
};

/// Descriptor for `Transfers`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transfersDescriptor = $convert.base64Decode(
    'CglUcmFuc2ZlcnMSLAoJdHJhbnNmZXJzGAEgAygLMg4uZ3Rmcy5UcmFuc2ZlclIJdHJhbnNmZX'
    'Jz');

@$core.Deprecated('Use transferDescriptor instead')
const Transfer$json = {
  '1': 'Transfer',
  '2': [
    {'1': 'from_stop', '3': 1, '4': 1, '5': 13, '10': 'fromStop'},
    {'1': 'to_stop', '3': 2, '4': 1, '5': 13, '10': 'toStop'},
    {'1': 'from_route', '3': 3, '4': 1, '5': 13, '10': 'fromRoute'},
    {'1': 'to_route', '3': 4, '4': 1, '5': 13, '10': 'toRoute'},
    {'1': 'from_trip', '3': 5, '4': 1, '5': 13, '10': 'fromTrip'},
    {'1': 'to_trip', '3': 6, '4': 1, '5': 13, '10': 'toTrip'},
    {
      '1': 'type',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.gtfs.TransferType',
      '10': 'type'
    },
    {
      '1': 'min_transfer_time',
      '3': 8,
      '4': 1,
      '5': 13,
      '10': 'minTransferTime'
    },
    {'1': 'delete', '3': 9, '4': 1, '5': 8, '10': 'delete'},
  ],
};

/// Descriptor for `Transfer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferDescriptor = $convert.base64Decode(
    'CghUcmFuc2ZlchIbCglmcm9tX3N0b3AYASABKA1SCGZyb21TdG9wEhcKB3RvX3N0b3AYAiABKA'
    '1SBnRvU3RvcBIdCgpmcm9tX3JvdXRlGAMgASgNUglmcm9tUm91dGUSGQoIdG9fcm91dGUYBCAB'
    'KA1SB3RvUm91dGUSGwoJZnJvbV90cmlwGAUgASgNUghmcm9tVHJpcBIXCgd0b190cmlwGAYgAS'
    'gNUgZ0b1RyaXASJgoEdHlwZRgHIAEoDjISLmd0ZnMuVHJhbnNmZXJUeXBlUgR0eXBlEioKEW1p'
    'bl90cmFuc2Zlcl90aW1lGAggASgNUg9taW5UcmFuc2ZlclRpbWUSFgoGZGVsZXRlGAkgASgIUg'
    'ZkZWxldGU=');

@$core.Deprecated('Use idStoreDescriptor instead')
const IdStore$json = {
  '1': 'IdStore',
  '2': [
    {
      '1': 'refs',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.gtfs.IdReference',
      '10': 'refs'
    },
  ],
};

/// Descriptor for `IdStore`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List idStoreDescriptor = $convert.base64Decode(
    'CgdJZFN0b3JlEiUKBHJlZnMYASADKAsyES5ndGZzLklkUmVmZXJlbmNlUgRyZWZz');

@$core.Deprecated('Use idReferenceDescriptor instead')
const IdReference$json = {
  '1': 'IdReference',
  '2': [
    {'1': 'block', '3': 1, '4': 1, '5': 14, '6': '.gtfs.Block', '10': 'block'},
    {'1': 'ids', '3': 2, '4': 3, '5': 9, '10': 'ids'},
    {'1': 'delta_skip', '3': 3, '4': 1, '5': 13, '10': 'deltaSkip'},
  ],
};

/// Descriptor for `IdReference`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List idReferenceDescriptor = $convert.base64Decode(
    'CgtJZFJlZmVyZW5jZRIhCgVibG9jaxgBIAEoDjILLmd0ZnMuQmxvY2tSBWJsb2NrEhAKA2lkcx'
    'gCIAMoCVIDaWRzEh0KCmRlbHRhX3NraXAYAyABKA1SCWRlbHRhU2tpcA==');

@$core.Deprecated('Use gtfsDeltaHeaderDescriptor instead')
const GtfsDeltaHeader$json = {
  '1': 'GtfsDeltaHeader',
  '2': [
    {'1': 'old_version', '3': 1, '4': 1, '5': 13, '10': 'oldVersion'},
    {'1': 'version', '3': 2, '4': 1, '5': 13, '10': 'version'},
    {'1': 'date', '3': 3, '4': 1, '5': 13, '10': 'date'},
    {'1': 'compressed', '3': 4, '4': 1, '5': 8, '10': 'compressed'},
    {'1': 'blocks', '3': 5, '4': 3, '5': 13, '10': 'blocks'},
  ],
};

/// Descriptor for `GtfsDeltaHeader`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gtfsDeltaHeaderDescriptor = $convert.base64Decode(
    'Cg9HdGZzRGVsdGFIZWFkZXISHwoLb2xkX3ZlcnNpb24YASABKA1SCm9sZFZlcnNpb24SGAoHdm'
    'Vyc2lvbhgCIAEoDVIHdmVyc2lvbhISCgRkYXRlGAMgASgNUgRkYXRlEh4KCmNvbXByZXNzZWQY'
    'BCABKAhSCmNvbXByZXNzZWQSFgoGYmxvY2tzGAUgAygNUgZibG9ja3M=');
