import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/queries/feed.dart';
import 'package:gtfs_proto_flutter/src/queries/stop.dart';

class Queries {
  final FeedQueries feeds;
  final StopQueries stops;

  Queries(DatabaseHelper database)
    : feeds = FeedQueries(database),
      stops = StopQueries(database);
}
