import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_depot_tracker_assessment_test/core/models/family_expenses_history_model.dart';

class HomeTaskBudgetSourceOpion {
  final HomeTaskSources? source;
  final String title;
  final String? description;
  final String icon;
  final void Function()? onTap;

  const HomeTaskBudgetSourceOpion({
    required this.source,
    required this.title,
    this.description,
    required this.icon,
    this.onTap,
  });
}

enum HomeTaskSources {
  add,
  create,
  categories,
  none,
}

String budgetSourceToString(HomeTaskSources source) {
  switch (source) {
    case HomeTaskSources.add:
      return "Add";
    case HomeTaskSources.create:
      return "Edit";
    case HomeTaskSources.categories:
      return "Delete";
    default:
      return "Unknown";
  }
}

final homeTaskExpensesHistoryProvider =
    StateProvider.autoDispose<ExpensesHistoryItems>(
  ((ref) => ExpensesHistoryItems.none),
);
