import 'dart:io';

import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/helpers/just_date.dart';
import 'package:gtfs_proto_flutter/src/helpers/just_time.dart';
import 'package:gtfs_proto_flutter/src/helpers/schedule_item.dart';
import 'package:gtfs_proto_flutter/src/models.dart';
import 'package:gtfs_proto_flutter/src/queries/service.dart';
import 'package:gtfs_proto_flutter/src/queries/stop.dart';

class ArrivalQueries {
  final DatabaseHelper _database;

  const ArrivalQueries(this._database);

  Future<List<Arrival>> findArrivals({
    required FeedId stopId,
    DateTime? now,
    int pastSeconds = 0,
    int futureSeconds = 3600,
  }) async {
    now ??= DateTime.now();
    final date = JustDate.fromDateTime(now);
    await ServiceQueries(_database).confirmTodayServices(date);
    final earliest = JustTime.fromDateTime(now).minusSeconds(pastSeconds);
    final latest = JustTime.fromDateTime(now).plusSeconds(futureSeconds);

    // 1. Query all trips that _might_ fit based on the date and the stop and the time.
    final db = await _database.database;
    final results = await db.rawQuery(
      'select * from ${ItineraryStopRef.kTable.name} '
      'left join ${DateServices.kTable.name} using (feed_id) '
      'inner join ${Trip.kTable.name} using (feed_id, itinerary_id, service_id) '
      'where feed_id = ? and stop_id = ? and date = ? and first_arrival <= ? and last_departure >= ?',
      [stopId.feedId, stopId.id, date.toInt(), earliest.toInt(), latest.toInt()],
    );

    // 2. Now filter trips that definitely fit.
    final trips = <Trip>[];
    for (final row in results) {
      final trip = Trip.fromJson(row);
      final sequenceId = row['sequence'] as int;
      if (trip.interval != null && trip.approximate) {
        // Frequency-based trip, we add it unconditionally.
        trips.add(trip);
      } else {
        final arrival = trip.arrivals[sequenceId];
        final departure = trip.departures[sequenceId];
        if (arrival != null || departure != null) {
          // We cannot calculate anything without times.
          if ((departure ?? arrival!) >= earliest && (arrival ?? departure!) <= latest) {
            trips.add(trip);
          }
        }
      }
    }

    // 3. Fetch the full data for those trips and build the arrivals, except for stops.
    final itineraryIds = trips.map((t) => t.itineraryId.id).toSet();
    final placeholders2 = List.generate(itineraryIds.length, (i) => '?').join(',');
    final results2 = await db.rawQuery(
      'select * from ${Itinerary.kTable.name} '
      'left join ${Shape.kTable.name} using (feed_id, shape_id) '
      'left join ${Route.kTable.name} using (feed_id, route_id) '
      'where feed_id = ? and itinerary_id in ($placeholders2)',
      [stopId.feedId, ...itineraryIds],
    );
    final routeMap = results2.map((row) => Route.fromJson(row)).associateBy((r) => r.id);
    final shapeMap = results2.map((row) => Shape.fromJson(row)).associateBy((s) => s.id);
    final itineraryMap = results2
        .map((row) => Itinerary.fromJson(row))
        .associateBy((i) => i.id)
        .cast<FeedId, Itinerary>();

    // 4. Fetch the stops.
    final stopMap = await StopQueries(
      _database,
    ).getByIds(itineraryMap.values.expand((i) => i.stops.map((ii) => FeedId(i.id.feedId, ii.stopId))));

    return trips
        .map(
          (trip) => Arrival(
            trip.toSpecificTrip(
              itinerary: itineraryMap[trip.itineraryId]!,
              route: routeMap[itineraryMap[trip.itineraryId]!.routeId]!,
              shape: shapeMap[itineraryMap[trip.itineraryId]!.shapeId],
              stops: stopMap,
              date: now!, // why is it nullable here?
            ),
            stopId.id,
          ),
        )
        .toList();
  }

  Future<List<ScheduleItem>> findDeparturesForDay(FeedId routeId, FeedId stopId, JustDate date) async {
    await ServiceQueries(_database).confirmTodayServices(date);

    final db = await _database.database;
    final results = await db.rawQuery(
      'select * from ${ItineraryStopRef.kTable.name} isr '
      'left join ${DateServices.kTable.name} using (feed_id) '
      'left join ${Itinerary.kTable.name} using (feed_id, itinerary_id) '
      'inner join ${Trip.kTable.name} using (feed_id, itinerary_id, service_id) '
      'where isr.feed_id = ? and isr.route_id = ? and isr.stop_id = ? and date = ?',
      [stopId.feedId, routeId.id, stopId.id, date.toInt()],
    );

    final schedule = <ScheduleItem>[];
    for (final row in results) {
      if (row['trip_id'] == null) continue;

      final sequenceId = row['sequence'] as int;
      final itineraryStop = Itinerary.fromJson(row).stops[sequenceId];
      final trip = Trip.fromJson(row);

      if (trip.approximate && trip.interval != null) {
        schedule.add(ScheduleItem.frequencyFromTrip(itineraryStop, trip));
      } else {
        final departure = trip.departures[sequenceId] ?? trip.arrivals[sequenceId];
        if (departure == null) continue;

        if (trip.interval == null) {
          // Just one arrival, add it.
          schedule.add(ScheduleItem.departureFromTrip(departure, itineraryStop, trip));
        } else {
          // Not approximate: add all arrivals.
          int after = departure - trip.departures.first!;
          JustTime current = trip.startTime!;
          while (current <= trip.endTime!) {
            schedule.add(ScheduleItem.departureFromTrip(current.plusSeconds(after), itineraryStop, trip));
            current = current.plusSeconds(trip.interval!);
          }
        }
      }
    }
    schedule.sort();
    return schedule;
  }

  Future<SpecificTrip?> getSpecificTrip(SpecificTripId id) async {
    final db = await _database.database;
    final results = await db.rawQuery(
      'select * from ${Trip.kTable.name} '
      'left join ${Itinerary.kTable.name} using (feed_id, itinerary_id) '
      'left join ${Shape.kTable.name} using (feed_id, shape_id) '
      'left join ${Route.kTable.name} using (feed_id, route_id) '
      'where feed_id = ? and trip_id = ?',
      [id.tripId.feedId, id.tripId.id],
    );
    if (results.isEmpty) return null;
    if (results.length > 1) throw Exception('Got more than one result for tripId $id: $results');

    final result = results.first;
    final trip = Trip.fromJson(result);
    final route = Route.fromJson(result);
    final itinerary = Itinerary.fromJson(result);
    final shape = result['path'] == null ? null : Shape.fromJson(result);

    final stopMap = await StopQueries(
      _database,
    ).getByIds(itinerary.stops.map((ii) => FeedId(itinerary.id.feedId, ii.stopId)));

    final specificTrip = trip.toSpecificTrip(
      route: route,
      itinerary: itinerary,
      shape: shape,
      stops: stopMap,
      date: id.departure,
    );

    return id.realTimeForStopIdx == null
        ? specificTrip
        : specificTrip.applyRealTimeArrival(id.realTimeForStopIdx!, id.departure);
  }
}

extension MapAssociateBy<E, T> on Iterable<E> {
  Map<T, E> associateBy(T Function(E) func) => {for (final el in this) func(el): el};
}
