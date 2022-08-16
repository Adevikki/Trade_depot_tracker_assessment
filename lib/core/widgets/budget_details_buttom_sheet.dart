import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_depot_tracker_assessment_test/core/models/task_budget_sources_model.dart';
import 'package:trade_depot_tracker_assessment_test/core/services/task_buttom_sheet_repository.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/async_value_widget.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/budget_items_list_screens/expenses_task_bottom_sheet/add_expenses.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/budget_items_list_screens/expenses_task_bottom_sheet/edit_budget_view.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/home/menu/menu_screens/home_view.dart';
import 'package:trade_depot_tracker_assessment_test/utils/colors.dart';
import 'package:trade_depot_tracker_assessment_test/utils/constants.dart';
import 'package:trade_depot_tracker_assessment_test/utils/styles.dart';

class SelectSourceBottomSheet extends ConsumerWidget {
  const SelectSourceBottomSheet({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;

    List<TaskBudgetSourceOpion> fundOptions = [
      TaskBudgetSourceOpion(
        title: 'Add an Expense',
        source: TaskSources.add,
        icon: '/cake.svg',
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddExpenses()));
        },
      ),
      TaskBudgetSourceOpion(
        title: 'Edit budget',
        source: TaskSources.edit,
        icon: '/edit_budget.svg',
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const EditBudgetScreen()));
        },
      ),
      TaskBudgetSourceOpion(
        title: 'Delete budget',
        source: TaskSources.delete,
        icon: '/delete_icon.svg',
        onTap: () {},
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

  final List<TaskBudgetSourceOpion> fundingOptions;

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
                ref.watch(taskExpensesHistoryProvider);
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
              //   style: Styles.title1(
              //       color: Styles.trackerGrey300, fontWeight: FontWeight.w700),
              // ),
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
          height: 7,
          color: AppColors.lightgrey,
        );
      },
    );
  }
}
