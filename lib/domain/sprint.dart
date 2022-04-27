import 'dart:convert';

import '../core/mixins/serialization.dart';
import 'task_board.dart';
import 'values/id.dart';

class Sprint with Serialization {
  Id<Sprint> id;

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

  String? description;

  TaskBoard board;

  DateTime? expectedStartDate;

  DateTime? expectedEndDate;

  DateTime? startDate;

  DateTime? endDate;

  Sprint({
    required this.id,
    required String name,
    this.description,
    required this.board,
    this.expectedStartDate,
    this.expectedEndDate,
    this.startDate,
    this.endDate,
  }) {
    this.name = name;
  }

  factory Sprint.fromMap(Map<String, dynamic> map) {
    return Sprint(
      id: Id<Sprint>(map['id']),
      name: map['name'],
      description: map['description'],
      board: TaskBoard.fromMap(map['board']),
      expectedStartDate: map['expectedStartDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expectedStartDate'])
          : null,
      expectedEndDate: map['expectedEndDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expectedEndDate'])
          : null,
      startDate: map['startDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startDate'])
          : null,
      endDate: map['endDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endDate'])
          : null,
    );
  }

  factory Sprint.fromJSON(String source) => Sprint.fromMap(json.decode(source));

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id.toInt(),
      'name': _name,
      'description': description,
      'board': board.toMap(),
      'expectedStartDate': expectedStartDate?.millisecondsSinceEpoch,
      'expectedEndDate': expectedEndDate?.millisecondsSinceEpoch,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
    };
  }
}
