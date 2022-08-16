import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_depot_tracker_assessment_test/core/models/budget_model.dart';
import 'package:trade_depot_tracker_assessment_test/core/services/budget_repository.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/async_value_widget.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/home/menu/menu_screens/home_view.dart';
import 'package:trade_depot_tracker_assessment_test/utils/colors.dart';
import 'package:trade_depot_tracker_assessment_test/utils/constants.dart';

class BudgetsScreen extends ConsumerWidget {
  const BudgetsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final screenSize = MediaQuery.of(context).size;
    final budgetSourceOptions = ref.watch(fetchBudgetListFutureProvider);

    return Container(
      color: AppColors.budgetbg,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.laptop_chromebook_rounded,
                        size: 43,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Budgets',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            AsyncValueWidget<BudgetList>(
              value: budgetSourceOptions,
              data: (budgetSourceOptions) {
                return _BudgetWidget(
                  budgetListOption: budgetSourceOptions,
                );
              },
              loading: () {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.black),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        )
      ]),
    );
  }
}

class _BudgetWidget extends StatelessWidget {
  const _BudgetWidget({
    Key? key,
    required this.budgetListOption,
  }) : super(key: key);
  final BudgetList budgetListOption;
  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    return Container(
      height: 400,
      width: 400,
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.48,
          crossAxisSpacing: 10,
          mainAxisSpacing: 1,
        ),
        itemCount: budgetListOption.length,
        shrinkWrap: true,

        itemBuilder: (context, index) {
          return Consumer(builder: (context, ref, child) {
            final budgetOption = budgetListOption[index];
            final selectedBudgetSource = ref.watch(budgetSourceProvider);
            final isSelected = budgetOption.item == selectedBudgetSource;
            // final icon = budgetOption.icon;
            return InkWell(
              onTap: () {
                budgetListOption.last == budgetOption
                    ? Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      )
                    : Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => budgetOption.route,
                        ),
                      );
              },
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 110,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: budgetListOption.last == budgetOption
                              ? Colors.white.withOpacity(0.3)
                              : Colors.white,
                        ),
                        child: budgetListOption.last == budgetOption
                            ? SvgPicture.asset(
                                '$kImagePath/small_plus.svg',
                                fit: BoxFit.none,
                              )
                            : Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      budgetOption.itemName!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: isSelected
                                            ? AppColors.bgColor
                                            : AppColors.lightgrey,
                                      ),
                                    ),
                                    const SizedBox(height: 2.5),
                                    Text(
                                      budgetOption.amount!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? Colors.white
                                            : AppColors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: LinearProgressIndicator(
                                        value: budgetOption.progress,
                                        minHeight: 10,
                                        color: budgetOption.color,
                                        backgroundColor: AppColors.bgColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      // Container(
                      //   height: 110,
                      //   width: 180,
                      //   decoration: BoxDecoration(
                      //     color: Colors.white.withOpacity(0.2),
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(20.0),
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: const [
                      //         Icon(
                      //           Icons.add_circle_outline,
                      //           size: 30,
                      //           color: AppColors.white,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          });
        },
        // ]),
      ),
    );
  }
}
