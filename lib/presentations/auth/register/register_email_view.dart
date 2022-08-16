import 'package:flutter/material.dart';
import 'package:trade_depot_tracker_assessment_test/core/app_bars/plain_app_bar.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/auth_text_field.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/button_widget.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/auth/register/code_verification_view.dart';
import 'package:trade_depot_tracker_assessment_test/utils/colors.dart';
import 'package:trade_depot_tracker_assessment_test/utils/styles.dart';
import 'package:trade_depot_tracker_assessment_test/utils/validations.dart';

class EmailRegisterView extends StatefulWidget {
  final String firstLastName;
  static String routeName = '/EmailRegisterView';
  const EmailRegisterView({Key? key, required this.firstLastName})
      : super(key: key);

  @override
  State<EmailRegisterView> createState() => _FullNameRegisterState();
}

class _FullNameRegisterState extends State<EmailRegisterView> {
  final _formKey = GlobalKey<FormState>();
  // Create storage

  // variable that holds the status of the password toggle
  bool hidePassword = true;

  bool _isEmailInvalid = false;

  // controllers
  final _emailController = TextEditingController();

  // validate login form
  void validateForm() {
    if (Validations.email(_emailController.text) != null) {
      setState(() {
        _isEmailInvalid = true;
      });
    } else {
      setState(() {
        _isEmailInvalid = false;
      });
    }

    // submit the form
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // this submits the form
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return CodeVerifyView(
            firstLastName: widget.firstLastName,
            email: _emailController.text,
          );
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: plainAppBar(
          showLogo: true,
          text: 'Sign up',
          context: context,
          color: Colors.black),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 60,
                  left: 20,
                  right: 20,
                  bottom: 80,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What’s your email?',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 38,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AuthTextField(
                          labelText: 'Enter your email address',
                          keyboardType: TextInputType.emailAddress,
                          validateFunction: Validations.email,
                          enableErrorMessage: _isEmailInvalid,
                          controller: _emailController,
                          hintText: '',
                          onChange: (val) {},
                          onSaved: (val) {},
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: const LinearProgressIndicator(
                            value: 0.5,
                            minHeight: 10,
                            color: AppColors.black,
                            backgroundColor: AppColors.bgColor,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ), // Show this portion when the keyboard is closed
                        SizedBox(
                          width: _mediaQuery.size.width,
                          child: ButtonWidget(
                              buttonText: 'Next',
                              buttonTextStyle: Styles.p2(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                              action: () {
                                // validate form
                                validateForm();
                              }),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
