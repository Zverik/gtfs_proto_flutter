/// Adds [nullIfEmpty] for easier protobuf parsing.
extension StringNullIfEmpty on String {
  String? get nullIfEmpty => isEmpty ? null : this;
}

/// Adds [nullIfZero] for easier protobuf parsing.
extension IntNullIfZero on int {
  int? get nullIfZero => this == 0 ? null : this;
}