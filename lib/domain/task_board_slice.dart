import 'dart:convert';

import '../core/mixins/serialization.dart';
import 'activity.dart';
import 'values/id.dart';

class TaskBoardSlice with Serialization {
  Id id;

  String name;

  String? description;

  Set<Activity> activities;

  TaskBoardSlice({
    required this.id,
    required this.name,
    this.description,
    this.activities = const {},
  });

  factory TaskBoardSlice.fromMap(Map<String, dynamic> map) {
    return TaskBoardSlice(
      id: Id(map['id']),
      name: map['name'],
      description: map['description'],
      activities: Set<Activity>.from(
        map['activities']?.map((activity) => Activity.fromMap(activity)) ?? {},
      ),
    );
  }

  factory TaskBoardSlice.fromJSON(String source) {
    return TaskBoardSlice.fromMap(json.decode(source));
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'activities': activities.map((activity) => activity.toMap()).toList(),
    };
  }
}
