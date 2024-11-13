import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../res/res.dart';

class CustomChip extends StatelessWidget {
  final double? fontSize;
  final String? label;
  final Color? labelColor;
  final Color? borderColor;
  final Function()? onTap;

  const CustomChip({
    super.key,
    this.fontSize,
    this.label = 'Label',
    this.labelColor = Colors.green,
    this.borderColor = Colors.green,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.green,
          borderRadius: BorderRadius.circular(AppDimens.appRadius6),
          border: Border.all(
            color: borderColor!,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          child: AutoSizeText(
            label!,
            style: AppTextStyles.regular13(
              color: labelColor,
            ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
