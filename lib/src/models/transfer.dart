import 'package:gtfs_proto_flutter/src/database/table_metadata.dart';

enum TransferType {
  possible,
  departureWaits,
  needsTime,
  notPossible,
  inSeat,
  inSeatForbidden,
}

class Transfer {
  final int feedId;
  final int? fromStopId;
  final int? toStopId;
  final int? fromRouteId;
  final int? toRouteId;
  final int? fromTripId;
  final int? toTripId;
  final TransferType type;
  final int? minTransferTimeSeconds;

  Transfer({
    required this.feedId,
    this.fromStopId,
    this.toStopId,
    this.fromRouteId,
    this.toRouteId,
    this.fromTripId,
    this.toTripId,
    this.type = TransferType.possible,
    this.minTransferTimeSeconds,
  });

  static const kTable = TableMetadata(
    name: 'transfers',
    columns: [
      'feed_id integer',
      'from_stop_id integer',
      'to_stop_id integer',
      'from_route_id integer',
      'to_route_id integer',
      'from_trip_id integer',
      'to_trip_id integer',
      'transfer_type integer',
      'min_time integer',
    ],
    indexes: ['feed_id'],
  );

  factory Transfer.fromJson(Map<String, dynamic> data) => Transfer(
    feedId: data['feed_id'],
    fromStopId: data['from_stop_id'],
    toStopId: data['to_stop_id'],
    fromRouteId: data['from_route_id'],
    toRouteId: data['to_route_id'],
    fromTripId: data['from_trip_id'],
    toTripId: data['to_trip_id'],
    type: TransferType.values[data['transfer_type'] ?? 0],
    minTransferTimeSeconds: data['min_time'],
  );

  Map<String, dynamic> toJson() => {
    'feed_id': feedId,
    'from_stop_id': fromStopId,
    'to_stop_id': toStopId,
    'from_route_id': fromRouteId,
    'to_route_id': toRouteId,
    'from_trip_id': fromTripId,
    'to_trip_id': toTripId,
    'transfer_type': type.index,
    'min_time': minTransferTimeSeconds,
  };

  @override
  bool operator ==(Object other) =>
      other is Transfer &&
      other.fromStopId == fromStopId &&
      other.toStopId == toStopId &&
      other.fromRouteId == fromRouteId &&
      other.toRouteId == toRouteId &&
      other.fromTripId == fromTripId &&
      other.toTripId == toTripId &&
      other.feedId == feedId;

  @override
  int get hashCode => Object.hash(
    fromStopId,
    toStopId,
    fromRouteId,
    toRouteId,
    fromTripId,
    toTripId,
    feedId,
  );
}
