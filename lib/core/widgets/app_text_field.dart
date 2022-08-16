import 'package:flutter/material.dart';
import 'package:trade_depot_tracker_assessment_test/utils/colors.dart';
import 'package:trade_depot_tracker_assessment_test/utils/styles.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    Key? key,
    this.labelText,
    this.fillcolor,
    this.onChanged,
    this.onFieldSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.controller,
    this.maxLines,
    this.textCapitalization = TextCapitalization.none,
    this.prefixIcon,
    this.backgroundColor,
    this.prefix,
    this.hintText,
    this.suffixIcon,
    this.leftSideLabelWidget,
    this.enabled,
    this.isInvalid = false,
    this.initialValue,
    this.focusedBorder,
    this.obscureText = false,
    this.contentPadding,
    this.enabledBorder,
  }) : super(key: key);

  final String? labelText;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Widget? leftSideLabelWidget;
  final Widget? suffixIcon;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Color? fillcolor;
  final Color? backgroundColor;
  final bool obscureText;
  final TextEditingController? controller;
  final Function? onFieldSubmitted;
  final int? maxLines;
  final String? hintText;
  final bool? enabled;
  final bool isInvalid;
  final String? initialValue;
  final EdgeInsets? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // widget.labelText != null
        //     ? const SizedBox(
        //         height: 10,
        //       )
        //     : Container(),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color:
                widget.isInvalid ? Styles.trackerWhite : widget.backgroundColor,
          ),
          height: widget.isInvalid ? null : 58,
          // constraints: widget.isInvalid
          //     ? widget.suffixIcon != null
          //         ? const BoxConstraints(
          //             minHeight: 60,
          //           )
          //         : const BoxConstraints(
          //             minHeight: 60,
          //           )
          //     : null,
          child: TextFormField(
            focusNode: focusNode,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onFieldSubmitted as void Function(String)?,
            initialValue: widget.initialValue,
            maxLines: widget.maxLines ?? 1,
            validator: widget.validator,
            controller: widget.controller,
            textCapitalization: widget.textCapitalization,
            enabled: widget.enabled,
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText,
              prefixIcon: widget.prefixIcon,
              // fillColor: Styles.trackerGrey200,
              labelStyle: TextStyle(
                color: focusNode.hasFocus ? AppColors.black : null,
              ),
              hintStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyText2?.color,
              ),
              contentPadding: widget.contentPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
              focusedBorder: widget.focusedBorder ??
                  OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.bgColor),
                    borderRadius: BorderRadius.circular(16),
                  ),
              prefix: widget.prefix != null
                  ? const Padding(
                      padding: EdgeInsets.only(left: 16),
                    )
                  : widget.prefix,
              suffix: widget.suffixIcon == null
                  ? const Padding(
                      padding: EdgeInsets.only(right: 16),
                    )
                  : null,
              suffixIcon: widget.suffixIcon,
              suffixIconConstraints: const BoxConstraints(maxHeight: 15),
              enabledBorder: widget.enabledBorder ??
                  OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(16),
                  ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(16),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade900),
                borderRadius: BorderRadius.circular(16),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade900),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
