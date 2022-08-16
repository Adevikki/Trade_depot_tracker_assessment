import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_depot_tracker_assessment_test/core/models/home_details_model.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/budget_items_list_screens/expenses_task_bottom_sheet/add_categories.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/budget_items_list_screens/expenses_task_bottom_sheet/add_expenses.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/budget_items_list_screens/expenses_task_bottom_sheet/create_budget_screen.dart';
import 'package:trade_depot_tracker_assessment_test/utils/colors.dart';
import 'package:trade_depot_tracker_assessment_test/utils/constants.dart';
import 'package:trade_depot_tracker_assessment_test/utils/styles.dart';

class HomeSelectSourceBottomSheet extends ConsumerWidget {
  const HomeSelectSourceBottomSheet({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;

    List<HomeTaskBudgetSourceOpion> fundOptions = [
      HomeTaskBudgetSourceOpion(
        title: 'Add an Expense',
        source: HomeTaskSources.add,
        icon: '/cake.svg',
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddExpenses()));
        },
      ),
      HomeTaskBudgetSourceOpion(
        title: 'Create a budget',
        source: HomeTaskSources.create,
        icon: '/edit_budget.svg',
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CreateBudgetScreen()));
          // Navigator.pop(context);
        },
      ),
      HomeTaskBudgetSourceOpion(
        title: 'Add a spending category',
        source: HomeTaskSources.categories,
        icon: '/edit_budget.svg',
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddCategoryBudgetScreen()));
          // Navigator.pop(context);
        },
      ),
    ];
    return Container(
      height: screenSize.height * 0.4,
      width: screenSize.width * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 5,
                width: 50,
                child: SvgPicture.asset(
                  '$kImagePath/line.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: _FundingOptionsList(
              fundingOptions: fundOptions,
            ),
          ),
        ],
      ),
    );
  }
}

class _FundingOptionsList extends StatelessWidget {
  const _FundingOptionsList({
    Key? key,
    required this.fundingOptions,
  }) : super(key: key);

  final List<HomeTaskBudgetSourceOpion> fundingOptions;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: fundingOptions.length,
      itemBuilder: (context, index) {
        return Consumer(
          builder: (context, ref, child) {
            final fundingOption = fundingOptions[index];
            final selectedFundingSource =
                ref.watch(homeTaskExpensesHistoryProvider);
            final isSelected = fundingOption.source == selectedFundingSource;

            return ListTile(
              onTap: () {
                Navigator.of(context).pop();
                fundingOption.onTap!();
              },
              leading: SvgPicture.asset(
                '$kImagePath${fundingOption.icon}',
                fit: BoxFit.cover,
              ),
              title: Text(
                fundingOption.title,
                style: Styles.captions2(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: isSelected ? AppColors.hintTextColor : AppColors.black,
                ),
              ),
            );
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 10,
          color: AppColors.lightgrey,
        );
      },
    );
  }
}
