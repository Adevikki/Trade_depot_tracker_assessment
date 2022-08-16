import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_depot_tracker_assessment_test/core/models/budget_model.dart';
import 'package:trade_depot_tracker_assessment_test/core/models/home_page_history_model.dart';

typedef HomePageHistoryList = List<HomePageHistoryClass>;

final budgetListRepositoryProvider = Provider<BudgetRepository>((ref) {
  return BudgetRepository(ref.read);
});

final fetchBudgetListFutureProvider =
    FutureProvider.autoDispose<HomePageHistoryList>((ref) async {
  return ref.watch(budgetListRepositoryProvider).fetchHomeBudgetList();
});

class BudgetRepository {
  const BudgetRepository(this.read);

  final Reader read;

  Future<HomePageHistoryList> fetchHomeBudgetList() async {
    return await Future.delayed(const Duration(seconds: 2), () {
      return const [
        HomePageHistoryClass(
          item: HomeItemSource.item1,
          itemName: '📄 Bill Payments',
          amount: '\$500.00',
        ),
        HomePageHistoryClass(
          item: HomeItemSource.item2,
          itemName: '💸 Transfers',
          amount: '\$500.00',
        ),
        HomePageHistoryClass(
          item: HomeItemSource.item3,
          itemName: '🍗 Food',
          amount: '\$500.00',
        ),
        HomePageHistoryClass(
          item: HomeItemSource.item4,
          itemName: '💳 Card purchases',
          amount: '\$500.00',
        ),
      ];
    });
  }
}
