import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_depot_tracker_assessment_test/core/models/budget_model.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/auth/login/login_view.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/budget_items_list_screens/family_budget_view.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/home/menu/menu_screens/home_view.dart';
import 'package:trade_depot_tracker_assessment_test/utils/colors.dart';

typedef BudgetList = List<BudgetClass>;

final budgetListRepositoryProvider = Provider<BudgetRepository>((ref) {
  return BudgetRepository(ref.read);
});

final fetchBudgetListFutureProvider =
    FutureProvider.autoDispose<BudgetList>((ref) async {
  return ref.watch(budgetListRepositoryProvider).fetchBudgetList();
});

class BudgetRepository {
  const BudgetRepository(this.read);

  final Reader read;

  Future<BudgetList> fetchBudgetList() async {
    return await Future.delayed(const Duration(seconds: 2), () {
      return const [
        BudgetClass(
            item: ItemSource.item1,
            itemName: 'Groceries',
            amount: '\$40/month',
            progress: 0.7,
            color: AppColors.percentage1,
            route: HomeScreen()),
        BudgetClass(
            item: ItemSource.item2,
            itemName: 'Family',
            amount: '\$1000/month',
            progress: 0.8,
            color: AppColors.percentage2,
            route: FamilyBudgetScreen()),
        BudgetClass(
            item: ItemSource.item3,
            itemName: 'Kids',
            amount: '\$35/month',
            progress: 0.3,
            color: AppColors.percentage3,
            route: HomeScreen()),
        BudgetClass(
            item: ItemSource.item4,
            itemName: 'Clothing',
            amount: '\$235/month',
            progress: 0.4,
            color: AppColors.percentage4,
            route: HomeScreen()),
        BudgetClass(
            item: ItemSource.item5,
            itemName: '',
            amount: '',
            progress: 0.0,
            icon: 'assets/images/add_icon.png',
            route: LoginView()),
      ];
    });
  }
}
