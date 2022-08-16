import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trade_depot_tracker_assessment_test/utils/colors.dart';
import 'package:trade_depot_tracker_assessment_test/utils/styles.dart';

class AuthTextField extends StatefulWidget {
  final double? width;
  final double? height;
  final String? hintText;
  final TextEditingController? controller;
  final int? minLines;
  final int? maxLines;
  final bool? obscureText;
  final bool? enabled;
  final FormFieldValidator<String>? validateFunction;
  final void Function(String) onSaved, onChange;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode, nextFocusNode;
  final VoidCallback? submitAction;
  final bool? enableErrorMessage;
  final void Function(String)? onFieldSubmitted;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? bordercolor, backgroundColor;
  final EdgeInsets? contentPadding;
  final bool? autofocus;
  final String? label;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final bool isLoading;

  const AuthTextField({
    Key? key,
    this.width,
    this.height = 60,
    this.contentPadding,
    this.backgroundColor,
    this.isLoading = false,
    required this.hintText,
    required this.controller,
    this.minLines = 1,
    this.obscureText = false,
    this.enabled = true,
    this.validateFunction,
    required this.onSaved,
    required this.onChange,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.nextFocusNode,
    this.submitAction,
    this.enableErrorMessage = true,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.prefixIcon,
    this.bordercolor,
    this.autofocus,
    this.label,
    this.labelText,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  final focusNode = FocusNode();
  String? error;
  @override
  Widget build(BuildContext context) {
    // final _light = Theme.of(context).brightness == Brightness.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: widget.backgroundColor ?? Styles.trackerWhite,
          ),
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.left,
            inputFormatters: widget.inputFormatters,
            autofocus: widget.autofocus == null ? false : widget.autofocus!,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textCapitalization: TextCapitalization.sentences,
            enabled: widget.enabled,
            onChanged: (val) {
              widget.validateFunction != null
                  ? error = widget.validateFunction!(val)
                  : error = null;
              setState(() {});
              if (widget.onChange != null) widget.onChange(val);
            },
            style: const TextStyle(
              fontSize: 18.0,
            ),
            key: widget.key,
            maxLines: widget.maxLines,
            controller: widget.controller,
            obscureText: widget.obscureText!,
            keyboardType: widget.keyboardType,
            validator: widget.validateFunction != null
                ? widget.validateFunction!
                : (value) {
                    return null;
                  },
            onSaved: (val) {
              error = widget.validateFunction!(val);
              setState(() {});
              widget.onSaved(val!);
            },
            textInputAction: widget.textInputAction,
            focusNode: widget.focusNode,
            onFieldSubmitted: widget.onFieldSubmitted,
            decoration: InputDecoration(
              contentPadding: widget.contentPadding ??
                  const EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 2),
              labelText: widget.labelText,
              alignLabelWithHint: true,
              hintText: widget.hintText,
              prefixIcon: widget.prefixIcon,
              // fillColor: AppColors.black,
              labelStyle: TextStyle(
                color: focusNode.hasFocus ? AppColors.white : null,
              ),
              hintStyle: const TextStyle(
                color: AppColors.hintTextColor,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              focusedBorder: InputBorder.none,
              suffixIcon: widget.suffixIcon,
              filled: false,
              errorBorder: InputBorder.none,
              errorStyle: const TextStyle(
                height: 0.0,
                fontSize: 0.0,
                color: Colors.red,
              ),
              focusedErrorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              // focusedBorder: InputBorder.none,
            ),
          ),
        ),
        if (error != null)
          Container(
            height: 5.0,
          )
        else
          Container(),
        if (error != null)
          Text(
            error!,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12.0,
            ),
          )
        else
          Container(),
        Container(
          height: 5,
        ),
      ],
    );
  }
}
