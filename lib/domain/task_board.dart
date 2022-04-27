import 'dart:convert';

import '../core/mixins/serialization.dart';
import 'task_board_slice.dart';

class TaskBoard with Serialization {
  Set<TaskBoardSlice> slices;

  int get activities {
    return slices.fold(0, (total, slice) => total + slice.activities.length);
  }

  TaskBoard({this.slices = const {}});

  factory TaskBoard.fromMap(Map<String, dynamic> map) {
    return TaskBoard(
      slices: Set<TaskBoardSlice>.from(
        map['slices']?.map((slice) => TaskBoardSlice.fromMap(slice)) ?? {},
      ),
    );
  }

  factory TaskBoard.fromJSON(String source) {
    return TaskBoard.fromMap(json.decode(source));
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'slices': slices.map((slice) => slice.toMap()).toList(),
    };
  }
}
