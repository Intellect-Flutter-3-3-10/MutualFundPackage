import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../my_app_exports.dart';

class CustomCheckboxTile extends StatelessWidget {
  final String title;
  final bool value;
  final bool selected;
  final Function(bool?)? onChanged;
  final Function()? iconTap;
  final IconData? trailingIcon;
  final TextStyle? titleStyle;
  final double? iconSize;
  final Color? iconColor;

  const CustomCheckboxTile({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.trailingIcon,
    this.iconTap,
    this.titleStyle,
    this.iconSize,
    this.iconColor,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      selected: selected,
      activeColor: AppColor.lightAmber,
      tileColor: AppColor.white,
      checkColor: AppColor.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AutoSizeText(
              title,
              style: titleStyle ?? AppTextStyles.regular14(),
            ),
          ),
          if (trailingIcon != null)
            GestureDetector(
              onTap: iconTap,
              child: Icon(
                trailingIcon,
                size: iconSize ?? 24.0,
                color: iconColor ?? AppColor.greyLight,
              ),
            ),
        ],
      ),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
