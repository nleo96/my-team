class Id<T> {
  final int _id;

  const Id(int id)
      : assert(id > 0, 'The id should be greater than 0.'),
        _id = id;

  factory Id.parse(String value) => Id(int.parse(value));

  static Id? tryParse(String value) {
    try {
      return Id.parse(value);
    } catch (_) {
      return null;
    }
  }

  int toInt() => _id;

  @override
  int get hashCode => _id.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Id<T> && other._id == _id;
  }

  @override
  String toString() => 'Id<ActivityItem>($_id)';
}
