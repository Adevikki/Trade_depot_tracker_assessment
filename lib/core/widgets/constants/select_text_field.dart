import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_depot_tracker_assessment_test/utils/colors.dart';
import 'package:trade_depot_tracker_assessment_test/utils/constants.dart';
import 'package:trade_depot_tracker_assessment_test/utils/styles.dart';
import 'package:trade_depot_tracker_assessment_test/utils/utils.dart';

class SelectFieldWidget extends StatelessWidget {
  final hintText;
  final value;
  final String? topText;
  final Function? action;
  final bool isError;
  final errorMessage;
  final String? prefixEmoji;
  final bool showDropDownIcon;

  SelectFieldWidget({
    this.hintText,
    this.value,
    this.action,
    this.topText,
    this.isError = false,
    this.errorMessage,
    this.prefixEmoji,
    this.showDropDownIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: topText != null,
          child: Column(
            children: [
              Text(
                '$topText',
                style: Styles.subtitle2(color: Styles.trackerGrey900),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
        InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: action as void Function()?,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 0,
                  child: Visibility(
                    visible: prefixEmoji != null,
                    child: Text(
                      '$prefixEmoji ',
                      style: TextStyle(fontSize: isIos() ? 25 : 20),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    value != null ? '$value' : '$hintText',
                    overflow: TextOverflow.ellipsis,
                    style: Styles.p1(
                        color: value != null
                            ? Styles.trackerGrey900
                            : Styles.trackerGrey500),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Visibility(
                      visible: showDropDownIcon,
                      child: const Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.xafeBgColor,
                      )),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: AppColors.bgColor,
              border: Border.all(
                color: isError
                    ? const Color(0xffD51313)
                    : (value != null
                        ? Styles.trackerGrey500
                        : Styles.trackerGrey300),
                width: value != null ? 1 : 0.5,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
            ),
          ),
        ),
        Visibility(
          visible: errorMessage != null && isError,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              Text(
                '$errorMessage',
                style: Styles.errorMessage(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
