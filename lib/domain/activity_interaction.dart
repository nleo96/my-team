import 'dart:convert';

import '../core/mixins/serialization.dart';
import 'activity_item.dart';
import 'person.dart';
import 'values/id.dart';

class ActivityInteraction with Serialization {
  Id<ActivityInteraction> id;

  Id<Person> person;

  Id<ActivityItem>? item;

  late String _description;

  String get description => _description;

  set description(String value) {
    if (description.isEmpty) {
      throw ArgumentError.value(
        value,
        'value',
        'The description can not be empty.',
      );
    }
    _description = value;
  }

  late Duration _workTime;

  Duration get workTime => _workTime;

  set workTime(Duration value) {
    if (value.isNegative) {
      throw ArgumentError.value(
        value,
        'value',
        'Work time must be a positive duration',
      );
    }
    _workTime = value;
  }

  late int _upVotes;

  int get upVotes => _upVotes;

  set upVotes(int value) {
    if (value.isNegative) {
      throw ArgumentError.value(
        value,
        'value',
        'Up votes must be a positive integer',
      );
    }
    _upVotes = value;
  }

  late int _downVotes;

  int get downVotes => _downVotes;

  set downVotes(int value) {
    if (value.isNegative) {
      throw ArgumentError.value(
        value,
        'value',
        'Down votes must be a positive integer',
      );
    }
    _downVotes = value;
  }

  ActivityInteraction({
    required this.id,
    required this.person,
    this.item,
    required String description,
    Duration workTime = Duration.zero,
    int upVotes = 0,
    int downVotes = 0,
  }) {
    this.description = description;
    this.workTime = workTime;
    this.upVotes = upVotes;
    this.downVotes = downVotes;
  }

  factory ActivityInteraction.fromMap(Map<String, dynamic> map) {
    return ActivityInteraction(
      id: Id<ActivityInteraction>(map['id']),
      person: Id<Person>(map['person']),
      item: map['item'] != null ? Id<ActivityItem>(map['item']) : null,
      description: map['Description'],
      workTime: Duration(milliseconds: map['workTime']),
      upVotes: map['UpVotes']?.toInt() ?? 0,
      downVotes: map['DownVotes']?.toInt() ?? 0,
    );
  }

  factory ActivityInteraction.fromJSON(String source) {
    return ActivityInteraction.fromMap(json.decode(source));
  }

  ActivityInteraction copyWith({
    Id<ActivityInteraction>? id,
    Id<Person>? person,
    Id<ActivityItem>? item,
    String? description,
    Duration? workTime,
    int? upVotes,
    int? downVotes,
  }) {
    return ActivityInteraction(
      id: id ?? this.id,
      person: person ?? this.person,
      item: item ?? this.item,
      description: description ?? _description,
      workTime: workTime ?? _workTime,
      upVotes: upVotes ?? _upVotes,
      downVotes: downVotes ?? _downVotes,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id.toInt(),
      'person': person.toInt(),
      'item': item?.toInt(),
      'description': _description,
      'workTime': _workTime,
      'upVotes': _upVotes,
      'downVotes': _downVotes,
    };
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    return other is ActivityInteraction && identical(this, other);
  }
}
