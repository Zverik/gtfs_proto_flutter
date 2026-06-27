/// A composite id for a feed and for anything in it. Should be passed to GTFS models
/// instead of a simple integer id.
class FeedId {
  final int feedId;
  final int id;

  const FeedId(this.feedId, this.id);

  factory FeedId.fromJson(Map<String, dynamic> data, String fieldName) => FeedId(data['feed_id'], data[fieldName]);

  @override
  bool operator ==(Object other) => other is FeedId && other.feedId == feedId && other.id == id;

  @override
  int get hashCode => Object.hash(feedId, id);

  @override
  String toString() => 'FeedId($feedId, $id)';
}
