class Name {
  final String first;

  final String middle;

  final String last;

  String get full => '$first $middle $last';

  const Name({
    required this.first,
    this.middle = '',
    required this.last,
  })  : assert(first.length > 0, 'The first name can not be empty.'),
        assert(last.length > 0, 'The last name can not be empty.');

  factory Name.from(String name) {
    final parts = name.split(' ');
    if (parts.length > 2) {
      return Name(
        first: parts.first,
        middle: parts.getRange(1, parts.length - 2).join(' '),
        last: parts.last,
      );
    } else {
      return Name(
        first: parts.first,
        last: parts.last,
      );
    }
  }

  static Name? tryParse(String name) {
    try {
      return Name.from(name);
    } catch (_) {
      return null;
    }
  }

  String initials([String separator = '']) {
    if (middle.isNotEmpty) {
      List<String> parts = [first, ...middle.split(' '), last];
      parts = parts.where((part) => part.isNotEmpty).toList();
      parts = parts.map((part) => part[0].toUpperCase()).toList();
      return parts.join(separator);
    } else {
      return '$first[0]$separator$last[0]';
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Name &&
        other.first == first &&
        other.middle == middle &&
        other.last == last;
  }

  @override
  int get hashCode => first.hashCode ^ middle.hashCode ^ last.hashCode;

  @override
  String toString() => full;
}
