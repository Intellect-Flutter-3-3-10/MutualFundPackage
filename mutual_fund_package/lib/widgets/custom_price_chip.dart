import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../my_app_exports.dart';

class CustomPriceChip extends StatelessWidget {
  final Color? borderColor;
  final Color? bgColoColor;
  final Color? textColor;
  final double? vPadding;
  final double? hPadding;
  final String? text;
  final TextStyle? textStyle;
  final Function()? onTap;

  const CustomPriceChip({
    super.key,
    this.borderColor,
    this.bgColoColor,
    this.vPadding,
    this.hPadding,
    this.text,
    this.textStyle,
    this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CommonOutLinedContainer(
        borderColor: borderColor ?? AppColor.lightAmber,
        vPadding: vPadding ?? AppDimens.appSpacing5,
        hPadding: hPadding ?? AppDimens.appSpacing10,
        borderRadius: AppDimens.appRadius6,
        child: AutoSizeText(
          text ?? "+ ${AppString.rupees}100",
          style: textStyle ?? AppTextStyles.regular13(color: textColor),
        ),
      ),
    );
  }
}
