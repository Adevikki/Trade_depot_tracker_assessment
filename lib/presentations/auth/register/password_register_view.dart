import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_depot_tracker_assessment_test/core/app_bars/plain_app_bar.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/app_text_field.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/button_widget.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/auth/login/login_auth_viewmodel.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/auth/login/login_view.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/auth/register/register_viewmodel.dart';
import 'package:trade_depot_tracker_assessment_test/utils/colors.dart';
import 'package:trade_depot_tracker_assessment_test/utils/styles.dart';
import 'package:trade_depot_tracker_assessment_test/utils/validations.dart';

class PasswordRegisterView extends ConsumerStatefulWidget {
  final String email;
  final String firstLastName;

  static String routeName = '/PasswordRegisterView';
  const PasswordRegisterView(
      {Key? key, required this.email, required this.firstLastName})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PasswordRegisterState();
}

class _PasswordRegisterState extends ConsumerState<PasswordRegisterView> {
  final _formKey = GlobalKey<FormState>();
  // Create storage

  // variable that holds the status of the password toggle
  bool hidePassword = true;

  bool _isPasswordInvalid = false;

  // controllers
  final _passwordController = TextEditingController();

  // validate login form
  Future<void> validateForm() async {
    if (Validations.loginPassword(_passwordController.text) != null) {
      setState(() {
        _isPasswordInvalid = true;
      });
    } else {
      setState(() {
        _isPasswordInvalid = false;
      });
    }

// submit the form
    if (_formKey.currentState!.validate() && !_isPasswordInvalid) {
      _formKey.currentState!.save();
      // this submits the form

      final response = await ref.read(authProvider.notifier).createUser(
            email: widget.email,
            password: _passwordController.text,
            fullName: widget.firstLastName,
          );
      if (response.successful) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginView(),
          ),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message),
          ),
        );
      }
      // _loginWithEmailAndPassword();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final state = ref.watch(authProvider);
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Add a Password',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 38,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: PasswordFieldWidget(
                          hidePassword: hidePassword,
                          isPasswordInvalid: _isPasswordInvalid,
                          passwordController: _passwordController,
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    // const SizedBox(
                    //   height: 12,
                    // ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.bgColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 6.5, bottom: 6.5, left: 10, right: 10),
                            child: !hidePassword
                                ? Text(
                                    'hide password',
                                    style: Styles.p2(
                                      color: AppColors.darkBlue,
                                      fontSize: 13,
                                    ),
                                  )
                                : Text(
                                    'show password',
                                    style: Styles.p2(
                                      color: AppColors.darkBlue,
                                      fontSize: 13,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const LinearProgressIndicator(
                        value: 0.8,
                        minHeight: 10,
                        color: AppColors.black,
                        backgroundColor: AppColors.bgColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Show this portion when the keyboard is closed
                    state.status == Status.loading
                        ? const Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: Center(
                                child: CircularProgressIndicator.adaptive(),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: _mediaQuery.size.width,
                            child: ButtonWidget(
                                buttonText: 'Next',
                                buttonTextStyle: Styles.p2(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                                action: () {
                                  setState(() {
                                    validateForm();
                                  });
                                }),
                          ),
                    const SizedBox(
                      height: 16,
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

class PasswordFieldWidget extends StatelessWidget {
  const PasswordFieldWidget({
    Key? key,
    required TextEditingController passwordController,
    required bool isPasswordInvalid,
    required this.hidePassword,
  })  : _passwordController = passwordController,
        _isPasswordInvalid = isPasswordInvalid,
        super(key: key);

  final TextEditingController _passwordController;
  final bool _isPasswordInvalid;
  final bool hidePassword;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      labelText: 'Enter password',
      contentPadding: const EdgeInsets.symmetric(horizontal: 1),
      enabledBorder: InputBorder.none,
      hintText: '',
      // textCapitalization: TextCapitalization.none,
      validator: Validations.loginPassword,
      controller: _passwordController,
      isInvalid: _isPasswordInvalid,
      obscureText: hidePassword,
    );
  }
}
