import 'dart:convert';

import '../core/mixins/serialization.dart';
import 'values/id.dart';

class ActivityItem with Serialization, Comparable<ActivityItem> {
  Id<ActivityItem> id;

  late int _index;

  int get index => _index;

  set index(int value) {
    if (value < 0) {
      throw ArgumentError.value(
        value,
        'value',
        'The index must be a positive integer.',
      );
    }
    _index = value;
  }

  Id<ActivityItem>? _parent;

  Id<ActivityItem>? get parent => _parent;

  set parent(Id<ActivityItem>? value) {
    if (value == id) {
      throw ArgumentError.value(
        value.toString(),
        'value',
        'The parent can not be itself.',
      );
    }
    _parent = value;
  }

  bool get hasParent => _parent != null;

  late String _description;

  String get description => _description;

  set description(String value) {
    if (value.isEmpty) {
      throw ArgumentError.value(
        value,
        'value',
        'The description can not be empty.',
      );
    }
    _description = value;
  }

  Set<int> dependencies;

  bool done;

  ActivityItem({
    required this.id,
    required int index,
    Id<ActivityItem>? parent,
    required String description,
    this.dependencies = const {},
    this.done = false,
  }) {
    this.index = index;
    this.parent = parent;
    this.description = description;
  }

  factory ActivityItem.fromMap(Map<String, dynamic> map) {
    return ActivityItem(
      id: Id<ActivityItem>(map['id']),
      index: map['index'],
      parent: map['parent'] != null ? Id<ActivityItem>(map['parent']) : null,
      description: map['description'],
      dependencies: Set<int>.from(map['dependencies'] ?? []),
      done: map['done'] ?? false,
    );
  }

  factory ActivityItem.fromJSON(String source) {
    return ActivityItem.fromMap(json.decode(source));
  }

  ActivityItem copyWith({
    Id<ActivityItem>? id,
    int? index,
    Id<ActivityItem>? parent,
    String? description,
    Set<int>? dependencies,
    bool? done,
  }) {
    return ActivityItem(
      id: id ?? this.id,
      index: index ?? _index,
      parent: parent ?? _parent,
      description: description ?? _description,
      dependencies: dependencies ?? this.dependencies,
      done: done ?? this.done,
    );
  }

  @override
  int compareTo(ActivityItem other) => index.compareTo(other.index);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'index': _index,
      'description': _description,
      'dependencies': dependencies.toList(),
      'done': done,
    };
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ActivityItem && other.id == id;
  }

  @override
  String toString() {
    return '''ActivityItem(
  id: $id, 
  parent: $_parent, 
  index: $_index,
  description: $_description, 
  dependencies: $dependencies, 
  done: $done
)''';
  }
}
