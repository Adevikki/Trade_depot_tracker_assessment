import 'package:flutter/material.dart';
import 'package:trade_depot_tracker_assessment_test/core/app_bars/plain_app_bar.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/auth_text_field.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/button_widget.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/auth/register/password_register_view.dart';
import 'package:trade_depot_tracker_assessment_test/utils/colors.dart';
import 'package:trade_depot_tracker_assessment_test/utils/styles.dart';
import 'package:trade_depot_tracker_assessment_test/utils/validations.dart';

class CodeVerifyView extends StatefulWidget {
  final String? email;
  final String? firstLastName;
  static String routeName = '/CodeVerifyView';
  const CodeVerifyView(
      {Key? key, required this.email, required this.firstLastName})
      : super(key: key);

  @override
  State<CodeVerifyView> createState() => _CodeVerifyViewState();
}

class _CodeVerifyViewState extends State<CodeVerifyView> {
  final _formKey = GlobalKey<FormState>();
  // Create storage

  // variable that holds the status of the password toggle
  bool hidePassword = true;

  bool _isCodeInvalid = false;

  // controllers
  final _codeController = TextEditingController();

  // validate login form
  void validateForm() {
    if (Validations.codeVerification(_codeController.text) != null) {
      setState(() {
        _isCodeInvalid = true;
      });
    } else {
      setState(() {
        _isCodeInvalid = false;
      });
    }

    // submit the form
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // this submits the form
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return PasswordRegisterView(
            firstLastName: widget.firstLastName!,
            email: widget.email!,
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
                      'Enter the code',
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
                          labelText:
                              'Enter the code sent to your email address',
                          keyboardType: TextInputType.number,
                          validateFunction: Validations.codeVerification,
                          textInputAction: TextInputAction.done,
                          enableErrorMessage: _isCodeInvalid,
                          controller: _codeController,
                          onChange: (value) {
                            setState(() {
                              if (Validations.codeVerification(value) != null) {
                                _isCodeInvalid = true;
                              } else {
                                _isCodeInvalid = false;
                              }
                            });
                          },
                          hintText: '',
                          onSaved: (val) {},
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: const LinearProgressIndicator(
                            value: 0.6,
                            minHeight: 10,
                            color: AppColors.black,
                            backgroundColor: AppColors.bgColor,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // // Show this portion when the keyboard is closed
                        SizedBox(
                          width: _mediaQuery.size.width,
                          child: ButtonWidget(
                            buttonText: 'Next',
                            buttonTextStyle: Styles.p2(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                            action: _codeController.text.isNotEmpty &&
                                    !_isCodeInvalid
                                ? () {
                                    // validate form
                                    validateForm();
                                  }
                                : null,
                          ),
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
