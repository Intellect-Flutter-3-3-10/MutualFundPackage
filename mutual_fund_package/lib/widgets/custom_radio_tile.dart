import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../my_app_exports.dart';

class CustomRadioTile<T> extends StatelessWidget {
  final String title;
  final Widget? subtitle;
  final T value;
  final T groupValue;
  final TextStyle? textStyle;
  final ValueChanged<T> onChanged;

  const CustomRadioTile({
    Key? key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      activeColor: AppColor.lightAmber,
      dense: false,
      title: AutoSizeText(
        title,
        style: textStyle ?? AppTextStyles.regular12(),
      ),
      subtitle: subtitle,
      // Subtitle is optional; if null, it won't be displayed
      value: value,
      groupValue: groupValue,
      onChanged: (T? selectedValue) {
        if (selectedValue != null) {
          onChanged(selectedValue);
        }
      },
    );
  }
}
