import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/app_text_field.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/button_widget.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/constants/select_text_field.dart';
import 'package:trade_depot_tracker_assessment_test/utils/colors.dart';
import 'package:trade_depot_tracker_assessment_test/utils/constants.dart';
import 'package:trade_depot_tracker_assessment_test/utils/styles.dart';
import 'package:trade_depot_tracker_assessment_test/utils/validations.dart';

class AddCategoryBudgetScreen extends ConsumerStatefulWidget {
  const AddCategoryBudgetScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddCategoryBudgetScreen> createState() =>
      _AddCategoryBudgetScreenState();
}

class _AddCategoryBudgetScreenState
    extends ConsumerState<AddCategoryBudgetScreen> {
  final _isCreateBudgetAmountInvalid = false;

  final _createBudgetAmountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // get the media query
    final _mediaQuery = MediaQuery.of(context).size;
    // final familyExpensesOptions = ref.watch(familyExpensesListFutureProvider);

    return Scaffold(
      backgroundColor: AppColors.buttonBlueColor,
      body: Container(
        padding: const EdgeInsets.symmetric(
          // horizontal: 16,
          vertical: 24,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(height: 30),
                  Align(
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
                        color: AppColors.black,
                        semanticsLabel: 'Back',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Add a spending category',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 50),
                  AppTextField(
                    labelText: 'Enter category name',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    backgroundColor: AppColors.bgColor,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validations.email,
                    // enableErrorMessage: _isCreateBudgetAmountInvalid,
                    controller: _createBudgetAmountController,
                    hintText: '',
                  ),
                  const SizedBox(height: 10),
                  SelectFieldWidget(
                    hintText: 'Choose category emoji',
                    // value: selectedNetwork.chain.isNotEmpty
                    //     ? selectedNetwork.chain
                    //     : null,
                    // action: () {
                    //   context.showBottomSheet(
                    //     child: SelectCryptoNetworkBottomSheet(),
                    //   );
                    // },
                  ),
                  const SizedBox(
                    height: 250,
                  ),
                  SizedBox(
                    width: _mediaQuery.width,
                    child: ButtonWidget(
                        buttonText: 'Create Category',
                        buttonTextStyle: Styles.p2(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                        action: () {
                          // validate form
                          // validateForm();
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
        height: _mediaQuery.height,
        width: _mediaQuery.width,
        decoration: const BoxDecoration(
          color: Styles.trackerWhite,
        ),
      ),
    );
  }
}
