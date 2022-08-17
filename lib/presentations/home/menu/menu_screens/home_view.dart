import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_depot_tracker_assessment_test/core/models/home_page_history_model.dart';
import 'package:trade_depot_tracker_assessment_test/core/services/home_page_history_repository.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/async_value_widget.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/home_details_bottom_sheet.dart';
import 'package:trade_depot_tracker_assessment_test/utils/colors.dart';
import 'package:trade_depot_tracker_assessment_test/utils/constants.dart';
import 'package:trade_depot_tracker_assessment_test/utils/styles.dart';

final selectedHomeBudgetProvider =
    StateProvider.autoDispose<HomePageHistoryClass>((ref) {
  return const HomePageHistoryClass.empty();
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // get the media query
    final _mediaQuery = MediaQuery.of(context).size;
    final homBudgetSourceOptions = ref.watch(fetchBudgetListFutureProvider);

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
                return Column(
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
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: const [
                                      Text(
                                        'This week',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      Icon(Icons.arrow_drop_down,
                                          color: AppColors.white),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: SvgPicture.asset(
                                    '$kImagePath/edit_icon.svg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return const HomeSelectSourceBottomSheet();
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 80, right: 80, top: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 83.9,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 140,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 60,
                                  right: 40,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Expenses',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            '\$4,750.00',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Income',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.white,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            '\$9,500.00',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 30),
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 24,
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
                            Expanded(
                              child: AsyncValueWidget<HomePageHistoryList>(
                                value: homBudgetSourceOptions,
                                data: (budgetSourceOptions) {
                                  return _HomeBudgetList(
                                    homebudgetListOption: budgetSourceOptions,
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
                                            valueColor: AlwaysStoppedAnimation(
                                                Colors.black),
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        // height: _mediaQuery.height,

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
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeBudgetList extends StatelessWidget {
  const _HomeBudgetList({
    Key? key,
    required this.homebudgetListOption,
  }) : super(key: key);

  final HomePageHistoryList homebudgetListOption;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: homebudgetListOption.length,
      itemBuilder: (context, index) {
        return Consumer(
          builder: (context, ref, child) {
            final budgetOption = homebudgetListOption[index];
            final selectedBudgetSource = ref.watch(expensesHistoryProvider);
            final isSelected = budgetOption.item == selectedBudgetSource;

            return ListTile(
              onTap: () {
                ref.read(expensesHistoryProvider.state).state =
                    budgetOption.item!;
                ref.read(selectedHomeBudgetProvider.state).state = budgetOption;
              },
              // leading: Text(
              //   budgetOption.icon!,
              //   style: isSelected
              //       ? Styles.p2(
              //           color: Styles.trackerPurple900,
              //         )
              //       : Styles.p2(
              //           color: Styles.trackerGrey900,
              //         ),
              // ),
              title: Text(
                budgetOption.itemName!,
                style: Styles.title1(
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              // subtitle: Text(
              //   budgetOption.amount!,
              //   style: Styles.captions2(
              //     fontWeight: FontWeight.w400,
              //   ),
              // ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    budgetOption.amount!,
                    style: Styles.captions2(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ],
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
