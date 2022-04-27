import 'dart:convert';

import '../core/mixins/serialization.dart';
import 'sprint.dart';
import 'values/id.dart';

class Project with Serialization {
  Id<Project> id;

  late String _name;

  String get name => _name;

  set name(String value) {
    if (value.isEmpty) {
      throw ArgumentError.value(
        value,
        'value',
        'The name can not be empty.',
      );
    }
    _name = value;
  }

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

  Set<Sprint> sprints;

  DateTime? deadLine;

  Project({
    required this.id,
    required String name,
    required String description,
    this.sprints = const {},
    this.deadLine,
  }) {
    this.name = name;
    this.description = description;
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: Id<Project>(map['id']),
      name: map['name'],
      description: map['description'],
      sprints: Set<Sprint>.from(
        map['sprints']?.map((sprint) => Sprint.fromMap(sprint)) ?? {},
      ),
      deadLine: map['deadLine'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['deadLine'])
          : null,
    );
  }

  factory Project.fromJSON(String source) {
    return Project.fromMap(json.decode(source));
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': _name,
      'description': _description,
      'sprints': sprints.map((sprint) => sprint.toMap()).toList(),
      'deadLine': deadLine?.millisecondsSinceEpoch,
    };
  }
}
