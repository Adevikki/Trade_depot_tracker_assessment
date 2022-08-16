import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trade_depot_tracker_assessment_test/utils/constants.dart';

PreferredSizeWidget plainAppBar(
    {showBackArrow = true, required BuildContext context, showLogo = true, Color? color, String? text}) {
  return AppBar(
    backgroundColor: kAppBackgroundColor,
    elevation: 0,
    centerTitle: true,
    leading: showBackArrow
        ? Padding(
            padding: const EdgeInsets.only(
              top: 18.0,
              left: 25,
            ),
            child: SizedBox(
              width: 24,
              height: 24,
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    '$kImagePath/arrow_left.svg',
                    width: 24,
                    height: 24,
                    semanticsLabel: 'Back',
                  ),
                ),
              ),
            ),
          )
        : Container(),
    title: showLogo
        ? Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              text!,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color ?? Colors.black,
              ),
            ),
          )
        : Container(),
  );
}
