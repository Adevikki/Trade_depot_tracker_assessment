import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_depot_tracker_assessment_test/core/models/family_expenses_history_model.dart';
import 'package:trade_depot_tracker_assessment_test/core/services/family_expenses_history_repository.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/async_value_widget.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/budget_details_buttom_sheet.dart';
import 'package:trade_depot_tracker_assessment_test/utils/colors.dart';
import 'package:trade_depot_tracker_assessment_test/utils/constants.dart';
import 'package:trade_depot_tracker_assessment_test/utils/styles.dart';

final selectedExpenseHistoryProvider =
    StateProvider.autoDispose<FamilyExpensesHistoryClass>((ref) {
  return const FamilyExpensesHistoryClass();
});

class FamilyBudgetScreen extends ConsumerWidget {
  const FamilyBudgetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // get the media query
    final _mediaQuery = MediaQuery.of(context).size;
    final familyExpensesOptions = ref.watch(familyExpensesListFutureProvider);

    return Scaffold(
      backgroundColor: AppColors.buttonBlueColor,
      body: Stack(
        children: [
          SafeArea(
            left: true,
            top: true,
            right: true,
            bottom: true,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                          left: 20,
                          right: 20,
                          bottom: 0,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                  ),
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (Navigator.of(context).canPop()) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: SvgPicture.asset(
                                          '$kImagePath/back_arrow.svg',
                                          width: 24,
                                          height: 24,
                                          semanticsLabel: 'Back',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Family',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                InkWell(
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: SvgPicture.asset(
                                        '$kImagePath/plus_icon.svg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    onTap: () {
                                      showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (BuildContext context) {
                                          return const SelectSourceBottomSheet();
                                        },
                                      );
                                    })
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 20, top: 40),
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    children: const [
                                      Text(
                                        '\$200.00 ',
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      Text(
                                        'spent',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: LinearProgressIndicator(
                                    value: 0.5,
                                    minHeight: 10,
                                    color: AppColors.white,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.3),
                                  ),
                                ),
                                const SizedBox(
                                  height: 17,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 10,
                                          right: 10),
                                      child: Text(
                                        '\$1000/month',
                                        style: Styles.captions2(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          // horizontal: 20,
                          vertical: 70,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 24,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                  width: 50,
                                  child: SvgPicture.asset(
                                    '$kImagePath/line.svg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Column(
                                  children: const [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Expense History',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                AsyncValueWidget<FamilyExpensesHistoryList>(
                                  value: familyExpensesOptions,
                                  data: (budgetSourceOptions) {
                                    return _FamilyBudgetList(
                                      expensesBudgetListOption:
                                          budgetSourceOptions,
                                    );
                                  },
                                  loading: () {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Center(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Colors.black),
                                              backgroundColor: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            height: _mediaQuery.height,
                            width: _mediaQuery.width,
                            decoration: const BoxDecoration(
                              color: Styles.trackerWhite,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FamilyBudgetList extends StatelessWidget {
  const _FamilyBudgetList({
    Key? key,
    required this.expensesBudgetListOption,
  }) : super(key: key);

  final FamilyExpensesHistoryList expensesBudgetListOption;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: expensesBudgetListOption.length,
      itemBuilder: (context, index) {
        return Consumer(
          builder: (context, ref, child) {
            final budgetOption = expensesBudgetListOption[index];
            final selectedBudgetSource =
                ref.watch(familyexpensesHistoryProvider);
            // final isSelected = budgetOption.item == selectedBudgetSource;
            // final icon = budgetOption.icon;
            return ListTile(
              onTap: () {},
              leading: SvgPicture.asset(
                '$kImagePath${budgetOption.icon}',
                fit: BoxFit.fill,
              ),
              title: Text(
                budgetOption.itemName!,
                style: Styles.title1(
                  color: AppColors.xafeBgColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                budgetOption.date!,
                style: Styles.title1(
                  color: AppColors.lightgrey,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              trailing: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 242, 245),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, left: 10, right: 10),
                  child: Text(
                    budgetOption.amount!,
                    style: Styles.captions2(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 20,
          color: Styles.trackerGrey400,
        );
      },
    );
  }
}
