import 'package:gtfs_proto_flutter/src/helpers/rolling_map.dart';
import 'package:gtfs_proto_flutter/src/proto/gtfs.pb.dart' as gtfs;
import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/database/table_metadata.dart';
import 'package:gtfs_proto_flutter/src/helpers/just_date.dart';

class Service {
  final FeedId id;
  final String originalId;
  final JustDate? start;
  final JustDate? end;
  final List<bool> weekdays;
  final Set<JustDate> added;
  final Set<JustDate> removed;

  Service({
    required this.id,
    required this.originalId,
    this.start,
    this.end,
    int weekdays = 127,
    this.added = const {},
    this.removed = const {},
  }) : weekdays = _parseWeekdays(weekdays);

  bool matches(JustDate date) {
    if (removed.contains(date)) return false;
    if (added.contains(date)) return true;
    if (start != null && date < start!) return false;
    if (end != null && date > end!) return false;
    return weekdays[date.weekday];
  }

  static const kTable = TableMetadata(
    name: 'services',
    key: 'service_id',
    columns: [
      'gtfs_service_id text',
      'start_date integer',
      'end_date integer',
      'weekdays integer',
      'added text',
      'removed text',
      'outer_start integer',
      'outer_end integer',
    ],
    indexes: ['feed_id, outer_start, outer_end'],
  );

  factory Service.fromJson(Map<String, dynamic> data) => Service(
    id: kTable.readId(data),
    originalId: data['gtfs_service_id'],
    start: JustDate.fromInt(data['start_date']),
    end: JustDate.fromInt(data['end_date']),
    weekdays: data['weekdays'],
    added: (data['added'] as String? ?? '')
        .split(",")
        .where((s) => s.isNotEmpty)
        .map((s) => JustDate.fromInt(int.parse(s)))
        .toSet(),
    removed: (data['removed'] as String? ?? '')
        .split(",")
        .where((s) => s.isNotEmpty)
        .map((s) => JustDate.fromInt(int.parse(s)))
        .toSet(),
  );

  Map<String, dynamic> toJson() {
    final outerStart = (added.union(
      removed,
    )).fold(start ?? added.first, (v, next) => next < v ? next : v);
    final outerEnd = (added.union(
      removed,
    )).fold(end ?? added.first, (v, next) => next > v ? next : v);
    return {
      ...kTable.writeId(id),
      'gtfs_service_id': originalId,
      'start_date': start?.toInt(),
      'end_date': end?.toInt(),
      'weekdays': serializeWeekdays(),
      'added': added.map((d) => d.toInt()).join(','),
      'removed': removed.map((d) => d.toInt()).join(','),
      'outer_start': outerStart.toInt(),
      'outer_end': outerEnd.toInt(),
    };
  }

  factory Service.fromProto(
    int feedId,
    String originalId,
    JustDate baseDate,
    gtfs.Service proto,
  ) => Service(
    id: FeedId(feedId, proto.serviceId),
    originalId: originalId,
    start: proto.startDate == 0 ? null : baseDate.plusDays(proto.startDate),
    end: proto.endDate == 0 ? null : baseDate.plusDays(proto.endDate),
    weekdays: proto.weekdays,
    added: proto.addedDays
        .rollingMap(baseDate, (prev, int cur) => prev.plusDays(cur))
        .toSet(),
    removed: proto.removedDays
        .rollingMap(baseDate, (prev, int cur) => prev.plusDays(cur))
        .toSet(),
  );

  static List<bool> _parseWeekdays(int value) =>
      List.generate(7, (i) => value & (2 << i) != 0);

  int serializeWeekdays() {
    int result = 0;
    for (int i = 0; i < 7; i++) {
      if (weekdays[i]) result += 2 << i;
    }
    return result;
  }

  @override
  bool operator ==(Object other) =>
      other is Service && other.id == id && other.originalId == originalId;

  @override
  int get hashCode => Object.hash(id, originalId);
}

class DateServices {
  final JustDate date;
  final FeedId serviceId;

  DateServices({required this.date, required this.serviceId});

  static const kTable = TableMetadata(
    name: 'date_services',
    columns: ['date integer', 'feed_id integer', 'service_id integer'],
    indexes: ['date, feed_id'],
    isManyToMany: true,
  );

  factory DateServices.fromJson(Map<String, dynamic> data) => DateServices(
    date: JustDate.fromInt(data['date']),
    serviceId: FeedId(data['feed_id'], data['service_id']),
  );

  Map<String, dynamic> toJson() => {
    'date': date.toInt(),
    'feed_id': serviceId.feedId,
    'service_id': serviceId.id,
  };

  @override
  bool operator ==(Object other) =>
      other is DateServices &&
      other.date == date &&
      other.serviceId == serviceId;

  @override
  int get hashCode => Object.hash(date, serviceId);
}
