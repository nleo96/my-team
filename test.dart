import 'package:intl/intl.dart';
import 'package:my_team/domain/activity_checklist.dart';
import 'package:my_team/domain/activity_item.dart';
import 'package:my_team/domain/values/id.dart';

void main() {
  final ActivityChecklist checklist = ActivityChecklist.empty();

  final Iterable<ActivityItem> items = [
    ActivityItem(
      id: const Id(1),
      index: 0,
      description: 'Some description.',
    ),
    ActivityItem(
      id: const Id(2),
      index: 1,
      parent: const Id(1),
      description: 'Some description.',
    ),
    ActivityItem(
      id: const Id(3),
      index: 2,
      parent: const Id(1),
      description: 'Some description.',
    ),
  ];

  checklist.addAll(items);

  print(DateTime.now().toIso8601String());
  print(DateTime.parse('2022-04-18T23:01:20.394331').toUtc().toIso8601String());
  print(checklist.toString());
}
