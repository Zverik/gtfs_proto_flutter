import 'dart:convert';

import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/database/table_metadata.dart';
import 'package:gtfs_proto_flutter/src/helpers/rolling_map.dart';
import 'package:gtfs_proto_flutter/src/proto/gtfs.pb.dart' as gtfs;
import 'package:latlong2/latlong.dart';

class Shape {
  final FeedId id;
  final String originalId;
  final List<LatLng> path;

  Shape({required this.id, required this.originalId, required this.path});

  static const kTable = TableMetadata(
    name: 'shapes',
    key: 'shape_id',
    columns: ['gtfs_shape_id text', 'path text'],
  );

  factory Shape.fromJson(Map<String, dynamic> data) => Shape(
    id: kTable.readId(data),
    originalId: data['gtfs_shape_id'],
    path: (json.decode(data['path']) as List<List<double>>)
        .map((ll) => LatLng(ll[0], ll[1]))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    ...kTable.writeId(id),
    'gtfs_shape_id': originalId,
    'path': json.encode(path.map((ll) => [ll.latitude, ll.longitude]).toList()),
  };

  factory Shape.fromProto(
    int feedId,
    String originalId,
    LatLng lastLoc,
    gtfs.Shape proto,
  ) {
    const protoScale = 100000.0;
    final lats = proto.latitudes
        .rollingMap(lastLoc.latitude * protoScale, (p, c) => p + c)
        .map((v) => v / protoScale)
        .toList();
    final lons = proto.longitudes
        .rollingMap(lastLoc.longitude * protoScale, (p, c) => p + c)
        .map((v) => v / protoScale)
        .toList();
    return Shape(
      id: FeedId(feedId, proto.shapeId),
      originalId: originalId,
      path: List.generate(lats.length, (i) => LatLng(lats[i], lons[i])),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is Shape && other.id == id && other.originalId == originalId;

  @override
  int get hashCode => Object.hash(id, originalId);
}
