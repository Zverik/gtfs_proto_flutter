import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/database/table_metadata.dart';

class Network {
  final FeedId id;
  final String gtfsId;
  final String? name;

  Network({required this.id, required this.gtfsId, this.name});

  static const kTable = TableMetadata(
    name: 'networks',
    key: 'network_id',
    columns: ['network_gtfs_id text, network_name text'],
  );

  factory Network.fromJson(Map<String, dynamic> data) => Network(
    id: kTable.readId(data),
    gtfsId: data['network_gtfs_id'],
    name: data['network_name'],
  );

  Map<String, dynamic> toJson() => {
    ...kTable.writeId(id),
    'network_gtfs_id': gtfsId,
    'network_name': name,
  };

  @override
  bool operator ==(Object other) => other is Network && other.id == id && other.gtfsId == gtfsId;

  @override
  int get hashCode => Object.hash(id, gtfsId);
}