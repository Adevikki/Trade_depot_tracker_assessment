import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trade_depot_tracker_assessment_test/utils/colors.dart';
import 'package:trade_depot_tracker_assessment_test/utils/styles.dart';
import 'package:trade_depot_tracker_assessment_test/utils/utils.dart';

class ButtonWidget extends StatelessWidget {
  final isLoading;
  final buttonText;
  final Function? action;
  final Color buttonColor;
  final Color? fontColor;
  final bool disabled;
  final bool isBorder;
  final double radius;
  final double height;
  final TextStyle? buttonTextStyle;

  const ButtonWidget({
    Key? key,
    this.isLoading = false,
    this.buttonText,
    this.action,
    this.buttonColor = AppColors.buttonBlueColor,
    this.fontColor,
    this.disabled = false,
    this.isBorder = false,
    this.radius = 16,
    this.height = 60,
    this.buttonTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: isIos()
          ? CupertinoButton(
              color:
                  buttonColor != null ? buttonColor : AppColors.buttonBlueColor,
              //disabledTextColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              disabledColor: Theme.of(context).primaryColor.withOpacity(0.8),
              onPressed: disabled ? null : action as void Function()?,
              child: isLoading
                  ? Theme(
                      data: ThemeData(
                        cupertinoOverrideTheme: const CupertinoThemeData(
                          brightness: Brightness.dark,
                        ),
                      ),
                      child: const CupertinoActivityIndicator(
                        radius: 20,
                        animating: true,
                      ))
                  : Text(
                      "$buttonText",
                      // ignore: prefer_if_null_operators
                      style: buttonTextStyle != null
                          ? buttonTextStyle
                          : Styles.btn1(
                              color:
                                  // ignore: prefer_if_null_operators
                                  fontColor == null
                                      ? AppColors.white
                                      : fontColor),
                    ),
            )
          : FlatButton(
              color:
                  buttonColor != null ? buttonColor : Styles.trackerPurple600,
              //disabledTextColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
              disabledColor: const Color.fromARGB(255, 191, 187, 248),
              disabledTextColor: AppColors.darkBlue,
              onPressed: disabled ? null : action as void Function()?,
              child: isLoading
                  ? const CircularProgressIndicator(
                      backgroundColor: AppColors.white,
                    )
                  : Text(
                      "$buttonText",
                      style: buttonTextStyle != null
                          ? buttonTextStyle
                          : Styles.btn1(
                              color: fontColor == null
                                  ? AppColors.white
                                  : fontColor),
                    ),
            ),
    );
  }
}
