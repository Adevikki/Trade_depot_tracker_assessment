import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:trade_depot_tracker_assessment_test/core/models/family_expenses_history_model.dart';

typedef FamilyExpensesHistoryList = List<FamilyExpensesHistoryClass>;

final familyExpensesHistoryListRepositoryProvider =
    Provider<FamilyBudgetRepository>((ref) {
  return FamilyBudgetRepository(ref.read);
});

final familyExpensesListFutureProvider =
    FutureProvider.autoDispose<FamilyExpensesHistoryList>((ref) async {
  return ref
      .watch(familyExpensesHistoryListRepositoryProvider)
      .fetchExpenseHistoryList();
});

class FamilyBudgetRepository {
  const FamilyBudgetRepository(this.read);

  final Reader read;

  Future<FamilyExpensesHistoryList> fetchExpenseHistoryList() async {
    return await Future.delayed(const Duration(seconds: 2), () {
      return [
        FamilyExpensesHistoryClass(
            item: ExpensesHistoryItems.item1,
            itemName: 'Celery',
            amount: '\$14.99',
            date: DateFormat("yyyy-MM-dd").format(DateTime.now()),
            icon: '/meat_item.svg'),
        FamilyExpensesHistoryClass(
          item: ExpensesHistoryItems.item2,
          itemName: 'Tomatoes',
          amount: '\$14.99',
          date: DateFormat("yyyy-MM-dd").format(DateTime.now()),
          icon: '/meat.svg',
        ),
        FamilyExpensesHistoryClass(
          item: ExpensesHistoryItems.item3,
          itemName: 'Milk & Sugar',
          amount: '\$14.99',
          date: DateFormat("yyyy-MM-dd").format(DateTime.now()),
          icon: '/meat.svg',
        ),
        FamilyExpensesHistoryClass(
          item: ExpensesHistoryItems.item4,
          itemName: 'Uber Fares',
          amount: '\$14.99',
          date: DateFormat("yyyy-MM-dd").format(DateTime.now()),
          icon: '/flight.svg',
        ),
      ];
    });
  }
}
