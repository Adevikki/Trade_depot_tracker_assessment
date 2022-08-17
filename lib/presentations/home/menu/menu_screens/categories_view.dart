import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/budget_details_buttom_sheet.dart';
import 'package:trade_depot_tracker_assessment_test/utils/colors.dart';
import 'package:trade_depot_tracker_assessment_test/utils/constants.dart';
import 'package:trade_depot_tracker_assessment_test/utils/styles.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    // final familyExpensesOptions = ref.watch();

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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.laptop_chromebook_rounded,
                                        size: 43,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Categories',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          // horizontal: 20,
                          vertical: 30,
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
                                        'No Spending categories',
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
                                // AsyncValueWidget<FamilyExpensesHistoryList>(
                                //   value: familyExpensesOptions,
                                //   data: (budgetSourceOptions) {
                                //     return _FamilyBudgetList(
                                //       expensesBudgetListOption:
                                //           budgetSourceOptions,
                                //     );
                                //   },
                                //   loading: () {
                                //     return Center(
                                //       child: Column(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.center,
                                //         children: const [
                                //           Center(
                                //             child: CircularProgressIndicator(
                                //               valueColor:
                                //                   AlwaysStoppedAnimation(
                                //                       Colors.black),
                                //               backgroundColor: Colors.white,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     );
                                //   },
                                // ),
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
