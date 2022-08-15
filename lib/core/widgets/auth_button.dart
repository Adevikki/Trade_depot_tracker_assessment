import 'package:flutter/material.dart';
import 'package:trade_depot_tracker_assessment_test/utils/colors.dart';

import 'constants/helpers.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    this.color,
    this.shadowColor,
    this.textColor,
    this.text,
    this.width,
    this.decoration,
    required this.icon,
    this.onTap,
  }) : super(key: key);
  final Color? color, textColor;
  final Color? shadowColor;
  final String? icon, text;
  final void Function()? onTap;
  final double? width;
  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: height(context) * 0.02),
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: decoration ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: color ?? AppColors.darkBlue,
              boxShadow: [
                BoxShadow(
                  color: shadowColor ?? Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                ),
              ],
            ),
        alignment: Alignment.center,
        width: width ?? double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              icon!,
              width: 24,
            ),
            // const SizedBox(
            //   width: 5,
            // ),
            Text(
              text ?? "Continue",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: textColor ?? AppColors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
