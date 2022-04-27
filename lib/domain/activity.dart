import 'dart:convert';

import '../core/core.dart';
import 'activity_checklist.dart';
import 'activity_interaction.dart';
import 'activity_item.dart';
import 'person.dart';
import 'values/id.dart';

enum ActivityPriority { undefined, lowest, low, normal, high, highest, urgent }

class Activity with Serialization {
  Id<Activity> id;

  ActivityPriority priority;

  late String _title;

  String get title => _title;

  set title(String value) {
    if (value.isEmpty) {
      throw ArgumentError.value(
        value,
        'value',
        'The title can not be empty.',
      );
    }
    _title = value;
  }

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

  ActivityChecklist? checklist;

  Set<ActivityInteraction> interactions;

  Set<Person> participants;

  Activity({
    required this.id,
    this.priority = ActivityPriority.undefined,
    required String title,
    required String description,
    this.checklist,
    this.interactions = const {},
    this.participants = const {},
  }) {
    this.title = title;
    this.description = description;
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    late final ActivityPriority priority;
    try {
      priority = ActivityPriority.values[map['priority']];
    } catch (_) {
      priority = ActivityPriority.undefined;
    }

    return Activity(
      id: Id<Activity>(map['id']),
      priority: priority,
      title: map['title'],
      description: map['description'],
      checklist: ActivityChecklist(
        map['checklist']?.map((item) => ActivityItem.fromMap(item)) ?? {},
      ),
      interactions: Set<ActivityInteraction>.from(
        map['interactions']?.map((log) => ActivityInteraction.fromMap(log)) ??
            {},
      ),
      participants: Set<Person>.from(
        map['participants']?.map((person) => Person.fromMap(person)) ?? {},
      ),
    );
  }

  factory Activity.fromJSON(String source) {
    return Activity.fromMap(json.decode(source));
  }

  Activity copyWith({
    Id<Activity>? id,
    String? title,
    String? description,
    ActivityChecklist? checklist,
    Set<ActivityInteraction>? interactions,
    Set<Person>? participants,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? _title,
      description: description ?? _description,
      checklist: checklist ?? this.checklist,
      interactions: interactions ?? this.interactions,
      participants: participants ?? this.participants,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'priority': priority.index,
      'title': _title,
      'description': _description,
      'checklist': checklist?.map((item) => item.toMap()).toList(),
      'interactions': interactions.map((log) => log.toMap()).toList(),
      'participants': participants.map((person) => person.toMap()).toList(),
    };
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Activity && other.id == id;
  }
}
