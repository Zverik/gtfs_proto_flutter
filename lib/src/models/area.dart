import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/database/table_metadata.dart';

class Area {
  final FeedId id;
  final String gtfsId;
  final String? name;

  Area({required this.id, required this.gtfsId, this.name});

  static const kTable = TableMetadata(
    name: 'areas',
    key: 'area_id',
    columns: ['area_gtfs_id text, area_name text'],
  );

  factory Area.fromJson(Map<String, dynamic> data) => Area(
    id: kTable.readId(data),
    gtfsId: data['area_gtfs_id'],
    name: data['area_name'],
  );

  Map<String, dynamic> toJson() => {
    ...kTable.writeId(id),
    'area_gtfs_id': gtfsId,
    'area_name': name,
  };

  @override
  bool operator ==(Object other) => other is Area && other.id == id && other.gtfsId == gtfsId;

  @override
  int get hashCode => Object.hash(id, gtfsId);
}