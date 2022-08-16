import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/app_button.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/auth/login/login_view.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/auth/register/register_name_view.dart';
import 'package:trade_depot_tracker_assessment_test/utils/colors.dart';
import 'package:trade_depot_tracker_assessment_test/utils/styles.dart';

class GetStartedView extends StatelessWidget {
  static String routeName = '/';
  const GetStartedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.xafeBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 248,
                left: 20,
                right: 20,
                bottom: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 80,
                    child: Text(
                      'Xafe',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Smart Budgeting',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 155,
                  ),
                  AppButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginView.routeName);
                    },
                    label: 'Login',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'New here? ',
                      style: Styles.p1(color: Styles.trackerGrey300),
                      children: [
                        TextSpan(
                          text: 'Create an account',
                          style: Styles.p1(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, FullNameRegisterView.routeName);
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Text(
                    'By continuing, you agree to Xafe’s terms of use \nand privacy policy.',
                    style: Styles.p1(
                      color: Styles.trackerGrey300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
