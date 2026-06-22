import 'package:fast_geohash/fast_geohash_str.dart';
import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/database/table_metadata.dart';
import 'package:gtfs_proto_flutter/src/helpers/null_if_empty.dart';
import 'package:gtfs_proto_flutter/src/proto/gtfs.pb.dart' as gtfs;
import 'package:latlong2/latlong.dart';

enum LocationType { stop, station, exit, node, boarding }

enum Accessibility { unknown, some, no }

class Stop {
  final FeedId id;
  final String originalId;
  final String? code;
  final String? name;
  final String? description;
  final LatLng location;
  final LocationType type;
  final int? parentStopId;
  final Accessibility accessibility;
  final String? platform;
  final int? zoneId;
  final List<int> areaIds;

  const Stop({
    required this.id,
    required this.originalId,
    this.code,
    this.name,
    required this.location,
    this.description,
    this.type = LocationType.stop,
    this.parentStopId,
    this.accessibility = Accessibility.unknown,
    this.platform,
    this.zoneId,
    this.areaIds = const [],
  });

  static const kTable = TableMetadata(
    name: 'stops',
    key: 'stop_id',
    columns: [
      'original_id text',
      'stop_code text',
      'stop_name text',
      'lat integer',
      'lon integer',
      'geohash text',
      'stop_desc text',
      'loc_type integer',
      'parent_id integer',
      'accessibility integer',
      'platform text',
      'zone_id integer',
      'area_ids text',
    ],
    indexes: ['geohash', 'code, feed_id'],
  );

  static const kCoordPrecision = 1e6;
  static const kGeohashPrecision = 7;

  factory Stop.fromJson(Map<String, dynamic> data) => Stop(
    id: kTable.readId(data),
    originalId: data['original_id'],
    code: data['stop_code'],
    name: data['stop_name'],
    location: LatLng(
      data['lat'] / kCoordPrecision,
      data['lon'] / kCoordPrecision,
    ),
    description: data['stop_desc'],
    type: LocationType.values[data['loc_type']],
    parentStopId: data['parent_id'],
    accessibility: data['accessibility'],
    platform: data['platform'],
    zoneId: data['zone_id'],
    areaIds: (data['area_ids'] as String? ?? '')
        .split(',')
        .where((s) => s.isNotEmpty)
        .map((s) => int.parse(s))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    ...kTable.writeId(id),
    'original_id': originalId,
    'stop_code': code,
    'stop_name': name,
    'lat': (location.latitude * kCoordPrecision).round(),
    'lon': (location.longitude * kCoordPrecision).round(),
    'geohash': geohash.encode(
      location.latitude,
      location.longitude,
      kGeohashPrecision,
    ),
    'stop_desc': description,
    'loc_type': type.index,
    'parent_id': parentStopId,
    'accessibility': accessibility.index,
    'platform': platform,
    'zone_id': zoneId,
    'area_ids': areaIds.join(','),
  };

  static final kLocationFromProto = {
    gtfs.LocationType.L_STOP: LocationType.stop,
    gtfs.LocationType.L_STATION: LocationType.station,
    gtfs.LocationType.L_EXIT: LocationType.exit,
    gtfs.LocationType.L_NODE: LocationType.node,
    gtfs.LocationType.L_BOARDING: LocationType.boarding,
  };

  static final kAccessibilityFromProto = {
    gtfs.Accessibility.A_UNKNOWN: Accessibility.unknown,
    gtfs.Accessibility.A_SOME: Accessibility.some,
    gtfs.Accessibility.A_NO: Accessibility.no,
  };

  factory Stop.fromProto(int feedId, String originalId, List<String> strings, LatLng lastLoc, gtfs.Stop proto) => Stop(
    id: FeedId(feedId, proto.stopId),
    originalId: originalId,
    code: proto.code.nullIfEmpty,
    name: proto.name == 0 ? null : strings[proto.name],
    location: LatLng(lastLoc.latitude + proto.lat / 100000.0, lastLoc.longitude + proto.lon / 100000.0),
    description: proto.desc.nullIfEmpty,
    type: kLocationFromProto[proto.type]!,
    accessibility: kAccessibilityFromProto[proto.wheelchair]!,
    parentStopId: proto.parentId.nullIfZero,
    platform: proto.platformCode,
    zoneId: proto.zone.nullIfZero,
    areaIds: List.of(proto.areas),
  );

  @override
  bool operator ==(Object other) =>
      other is Stop && other.id == id && other.originalId == originalId;

  @override
  int get hashCode => Object.hash(id, originalId);
}

class StopTerm {
  final FeedId stopId;
  final String word;

  StopTerm({required this.stopId, required this.word});

  static const kTable = TableMetadata(
    name: 'stop_terms',
    columns: ['word text', 'feed_id integer', 'stop_id integer'],
    indexes: ['word'],
  );

  factory StopTerm.fromJson(Map<String, dynamic> data) => StopTerm(
    word: data['word'],
    stopId: FeedId(data['feed_id'], data['stop_id']),
  );

  Map<String, dynamic> toJson() => {
    'word': word,
    'feed_id': stopId.feedId,
    'stop_id': stopId.id,
  };

  @override
  bool operator ==(Object other) =>
      other is StopTerm && other.word == word && other.stopId == stopId;

  @override
  int get hashCode => Object.hash(word, stopId);
}
