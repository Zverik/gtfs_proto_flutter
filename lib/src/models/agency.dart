import 'package:gtfs_proto_flutter/src/helpers/null_if_empty.dart';
import 'package:gtfs_proto_flutter/src/proto/gtfs.pb.dart' as gtfs;
import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/database/table_metadata.dart';

class Agency {
  final FeedId id;
  final String gtfsId;
  final String name;
  final String? url;
  final String? timezone;
  final String? lang;
  final String? phone;
  final String? fareUrl;
  final String? email;

  Agency({
    required this.id,
    required this.gtfsId,
    required this.name,
    this.url,
    this.timezone,
    this.lang,
    this.phone,
    this.fareUrl,
    this.email,
  });

  static const kTable = TableMetadata(
    name: 'agencies',
    key: 'agency_id',
    columns: [
      'agency_gtfs_id text',
      'name text',
      'url text',
      'timezone text',
      'lang text',
      'phone text',
      'fare_url text',
      'email text',
    ],
  );

  factory Agency.fromJson(Map<String, dynamic> data) => Agency(
    id: kTable.readId(data),
    gtfsId: data['agency_gtfs_id'],
    name: data['name'],
    url: data['url'],
    timezone: data['timezone'],
    lang: data['lang'],
    phone: data['phone'],
    fareUrl: data['fare_url'],
    email: data['email'],
  );

  Map<String, dynamic> toJson() => {
    ...kTable.writeId(id),
    'agency_gtfs_id': gtfsId,
    'name': name,
    'url': url,
    'timezone': timezone,
    'lang': lang,
    'phone': phone,
    'fare_url': fareUrl,
    'email': email,
  };

  factory Agency.fromProto(int feedId, String gtfsId, gtfs.Agency proto, Agency? old) => Agency(
    id: FeedId(feedId, proto.agencyId),
    gtfsId: gtfsId,
    name: proto.name.nullIfEmpty ?? old!.name,
    url: proto.url.nullIfEmpty ?? old?.url,
    timezone: proto.timezone.nullIfEmpty ?? old?.timezone,
    lang: proto.lang.nullIfEmpty ?? old?.lang,
    phone: proto.phone.nullIfEmpty ?? old?.phone,
    fareUrl: proto.fareUrl.nullIfEmpty ?? old?.fareUrl,
    email: proto.email.nullIfEmpty ?? old?.email,
  );

  @override
  bool operator ==(Object other) => other is Agency && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
