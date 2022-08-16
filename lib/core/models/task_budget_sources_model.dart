import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_depot_tracker_assessment_test/core/models/family_expenses_history_model.dart';

class TaskBudgetSourceOpion {
  final TaskSources? source;
  final String title;
  final String? description;
  final String icon;
  final void Function()? onTap;

  const TaskBudgetSourceOpion({
    required this.source,
    required this.title,
    this.description,
    required this.icon,
    this.onTap,
  });
}

enum TaskSources {
  add,
  edit,
  delete,
  none,
}

String budgetSourceToString(TaskSources source) {
  switch (source) {
    case TaskSources.add:
      return "Add";
    case TaskSources.edit:
      return "Edit";
    case TaskSources.delete:
      return "Delete";
    default:
      return "Unknown";
  }
}

final taskExpensesHistoryProvider =
    StateProvider.autoDispose<ExpensesHistoryItems>(
  ((ref) => ExpensesHistoryItems.none),
);
