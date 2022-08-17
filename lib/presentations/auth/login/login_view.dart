import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_depot_tracker_assessment_test/core/app_bars/plain_app_bar.dart';
import 'package:trade_depot_tracker_assessment_test/core/models/api_response.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/app_text_field.dart';
import 'package:trade_depot_tracker_assessment_test/core/widgets/button_widget.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/auth/login/login_auth_viewmodel.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/auth/register/register_viewmodel.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/home/menu/custom_bottom_navigation.dart';
import 'package:trade_depot_tracker_assessment_test/utils/colors.dart';
import 'package:trade_depot_tracker_assessment_test/utils/constants.dart';
import 'package:trade_depot_tracker_assessment_test/utils/styles.dart';
import 'package:trade_depot_tracker_assessment_test/utils/validations.dart';

class LoginView extends ConsumerStatefulWidget {
  static String routeName = '/login';
  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  // Create storage

  // variable that holds the status of the password toggle
  bool hidePassword = true;

  bool _isEmailInvalid = false;
  bool _isPasswordInvalid = false;

  // controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // validate login form
  void validateForm() async {
    if (Validations.email(_emailController.text) != null) {
      setState(() {
        _isEmailInvalid = true;
      });
    } else {
      setState(() {
        _isEmailInvalid = false;
      });
    }

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
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final response = await ref
          .read(loginAuthProvider.notifier)
          .loginWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      if (response.successful) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const CustomBottomNavigation(),
          ),
          (route) => false,
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  AppTextField passwordFieldContainer() {
    return AppTextField(
      labelText: 'Password',
      backgroundColor: AppColors.bgColor,
      enabledBorder: InputBorder.none,
      hintText: '',
      // textCapitalization: TextCapitalization.none,
      validator: Validations.loginPassword,
      controller: _passwordController,
      isInvalid: _isPasswordInvalid,
      textInputAction: TextInputAction.done,

      obscureText: hidePassword,

      suffixIcon: IconButton(
          padding: EdgeInsets.zero,
          icon: !hidePassword
              ? SvgPicture.asset(
                  '$kImagePath/eye.svg',
                  width: 25,
                )
              : SvgPicture.asset(
                  '$kImagePath/eye_slash.svg',
                  width: 25,
                  color: Styles.blue900,
                ),
          onPressed: () {
            setState(() {
              hidePassword = !hidePassword;
            });
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginAuthProvider);
    final _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: plainAppBar(showLogo: false, context: context),
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
                    const SizedBox(height: 10),
                    const Text(
                      'Welcome back',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Text(
                      'Login to your account',
                      style: TextStyle(
                        color: Styles.trackerGrey500,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextField(
                          labelText: 'email Address',
                          enabledBorder: InputBorder.none,
                          backgroundColor: AppColors.bgColor,
                          fillcolor: Styles.trackerGrey200,
                          hintText: '',
                          keyboardType: TextInputType.emailAddress,
                          validator: Validations.email,
                          isInvalid: _isEmailInvalid,
                          controller: _emailController,
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        // Password input field container
                        passwordFieldContainer(),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: AppColors.bgColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 6.5, bottom: 6.5, left: 10, right: 10),
                                child: Text(
                                  'Forgot Password?',
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
                          height: 256.5,
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
                                  buttonText: 'Login',
                                  action: _emailController.text.isNotEmpty &&
                                          _passwordController.text.isNotEmpty
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
