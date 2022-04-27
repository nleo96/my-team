import 'activity_item.dart';

class ActivityChecklist extends Iterable<ActivityItem> {
  final List<ActivityItem> _items;

  ActivityChecklist(Iterable<ActivityItem> items) : _items = items.toList();

  ActivityChecklist.empty() : _items = [];

  @override
  Iterator<ActivityItem> get iterator => _items.iterator;

  void add(ActivityItem element) {
    if (element.hasParent) {
      final ActivityItem parent = parentOf(element);
      if (parent.hasParent) {
        throw ArgumentError.value(
          element.id.toString(),
          'element',
          '''The element can not point to a parent that points to another parent.
It points to ${element.parent} that points to ${parent.parent} as parent''',
        );
      }
    }

    if (_items.contains(element)) {
      _items[_items.indexOf(element)] = element;
    } else {
      _items.add(element);
    }
  }

  void addAll(Iterable<ActivityItem> items) {
    List<ActivityItem> sortedItems = items.toList(growable: false);
    sortedItems.sort((_, next) => !next.hasParent ? 1 : -1);

    for (final ActivityItem element in sortedItems) {
      add(element);
    }
  }

  bool remove(
    ActivityItem item, {
    bool maintainChildren = true,
  }) {
    if (!_items.contains(item)) return false;
    if (maintainChildren) {
      for (final ActivityItem child in childrenOf(item)) {
        child.parent = null;
      }
    } else {
      _items.removeWhere((element) => element.parent == item.id);
    }
    return _items.remove(item);
  }

  void removeAt(
    int index, {
    bool maintainChildren = true,
  }) {
    remove(_items.elementAt(index), maintainChildren: maintainChildren);
  }

  void removeRange(
    int start,
    int end, {
    bool maintainChildren = true,
  }) {
    Iterable<ActivityItem> toBeRemoved = List.from(_items.getRange(start, end));
    for (final ActivityItem element in toBeRemoved) {
      remove(element, maintainChildren: maintainChildren);
    }
  }

  void removeWhere(
    bool Function(ActivityItem item) test, {
    bool maintainChildren = true,
  }) {
    Iterable<ActivityItem> toBeRemoved = List.from(_items.where(test));
    for (final ActivityItem element in toBeRemoved) {
      remove(element, maintainChildren: maintainChildren);
    }
  }

  void clear() => _items.clear();

  Iterable<ActivityItem> reversed() => _items.reversed;

  Map<int, ActivityItem> asMap() => _items.asMap();

  void sort([Comparator<ActivityItem>? compare]) => _items.sort(compare);

  ActivityItem parentOf(ActivityItem element) {
    for (final ActivityItem item in _items) {
      if (item.id == element.parent) return item;
    }
    throw ArgumentError.value(
      element,
      'element',
      'The parent of ${element.id} was not found.',
    );
  }

  Iterable<ActivityItem> childrenOf(ActivityItem element) sync* {
    yield* _items.where((item) => item.parent == element.id);
  }

  ActivityItem operator [](int index) => _items.elementAt(index);

  Iterable<ActivityItem> allWithoutParent() sync* {
    yield* _items.where((element) => !element.hasParent);
  }

  @override
  String toString() {
    if (_items.isEmpty) return '[]';

    final StringBuffer string = StringBuffer();
    string.writeln('[');
    string.writeAll(_items, ',\n');
    string.writeln();
    string.write(']');

    return string.toString();
  }
}
