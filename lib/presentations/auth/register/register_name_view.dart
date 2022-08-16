import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trade_depot_tracker_assessment_test/core/app_bars/plain_app_bar.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/auth_text_field.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/button_widget.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/auth/register/register_email_view.dart';
import 'package:trade_depot_tracker_assessment_test/utils/colors.dart';
import 'package:trade_depot_tracker_assessment_test/utils/styles.dart';
import 'package:trade_depot_tracker_assessment_test/utils/validations.dart';

class FullNameRegisterView extends StatefulWidget {
  static String routeName = '/FullNameRegisterView';
  const FullNameRegisterView({Key? key}) : super(key: key);

  @override
  State<FullNameRegisterView> createState() => _FullNameRegisterState();
}

class _FullNameRegisterState extends State<FullNameRegisterView> {
  final _formKey = GlobalKey<FormState>();
  // Create storage

  // variable that holds the status of the password toggle

  bool _isFirstLastNameInvalid = false;

  // controllers
  final _firstLastNameController = TextEditingController();

  @override
  void dispose() {
    _firstLastNameController.dispose();
    super.dispose();
  }

  // validate login form
  void validateForm() {
    if (Validations.firstName(_firstLastNameController.text) != null) {
      setState(() {
        _isFirstLastNameInvalid = true;
      });
    } else {
      setState(() {
        _isFirstLastNameInvalid = false;
      });
    }

    // submit the form
    if (_formKey.currentState!.validate() && !_isFirstLastNameInvalid) {
      _formKey.currentState!.save();

      // this submits the form
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return EmailRegisterView(
              firstLastName: _firstLastNameController.text);
        }),
      );
      // _loginWithEmailAndPassword();
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
                      'What’s your name?',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 38,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 12,
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AuthTextField(
                          labelText: 'Enter your first name and last name',
                          // enabledBorder: InputBorder.none,
                          hintText: '',
                          keyboardType: TextInputType.name,
                          validateFunction: Validations.firstName,
                          enableErrorMessage: _isFirstLastNameInvalid,
                          controller: _firstLastNameController,
                          onChange: (val) {}, onSaved: (val) {},
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: const LinearProgressIndicator(
                            value: 0.3,
                            minHeight: 10,
                            color: AppColors.black,
                            backgroundColor: AppColors.bgColor,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Show this portion when the keyboard is closed
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
                                validateForm();
                              },
                              // _firstLastNameController
                              //             .text.isNotEmpty &&
                              //         Validations.firstName(
                              //                 _firstLastNameController.text) ==
                              //             null
                              //     ? () {
                              //         // validate form
                              //         validateForm();
                              //       }
                              //     : null,
                            )),
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
