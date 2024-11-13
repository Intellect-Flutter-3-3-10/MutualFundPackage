import 'package:flutter/material.dart';
import 'package:intellect_mutual_fund/my_app_exports.dart';

import '../res/res.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? borderColor;
  final Color? focusUnderLineColor;
  final int? maxLines;
  final bool isReadOnly;
  final bool isPrefixWidget;
  final Widget? prefixWidget;

  const CustomTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.isReadOnly = false,
    this.borderColor,
    this.focusUnderLineColor,
    this.isPrefixWidget = false,
    this.prefixWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      maxLines: maxLines,
      readOnly: isReadOnly,
      style: AppTextStyles.regular12(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimens.appSpacing10,
          vertical: 0,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.appRadius12),
          borderSide: BorderSide(
            color: focusUnderLineColor ?? AppColor.greyLightest,
            width: 0.5,
          ),
        ),
        hintText: hintText,
        prefixIcon: isPrefixWidget
            ? SizedBox(
                child: prefixWidget,
              )
            : prefixIcon != null
                ? Icon(prefixIcon, color: UtilsMethod().getColorBasedOnTheme(context))
                : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: UtilsMethod().getColorBasedOnTheme(context)) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.appRadius12),
          borderSide: BorderSide(
            color: borderColor ?? AppColor.greyLightest,
            width: 0.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.appRadius12),
          borderSide: BorderSide(
            color: borderColor ?? AppColor.greyLightest,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.appRadius12),
          borderSide: BorderSide(
            color: focusUnderLineColor ?? AppColor.greyLightest,
            width: 0.5,
          ),
        ),
      ),
    );
  }
}
