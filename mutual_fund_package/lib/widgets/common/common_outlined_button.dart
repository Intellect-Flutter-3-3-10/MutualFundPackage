import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../res/res.dart';

class CommonOutlinedButton extends StatelessWidget {
  final Color? bgColor;
  final Color? fgColor;
  final Color? borderColor;
  final String? btnText;

  final TextStyle? textStyle;
  final Function()? onTap;
  final double? height;
  final double? width;

  const CommonOutlinedButton({
    super.key,
    this.bgColor,
    this.borderColor,
    this.btnText = 'Text',
    this.onTap,
    this.height,
    this.width,
    this.textStyle,
    this.fgColor,
  });

  @override
  Widget build(BuildContext context) {
    bool theme = Theme.of(context).brightness == Brightness.dark;
    Color tColor = theme ? Colors.black : Colors.white;
    // Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.90,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor ?? AppColor.lightAmber),
          // padding: EdgeInsets.symmetric(vertical: vPadding!,horizontal: hPadding!),
          backgroundColor: bgColor ?? AppColor.lightestAmber,
          // foregroundColor: fgColor ?? UtilsMethod().getColorBasedOnTheme(context),
          foregroundColor: fgColor ?? AppColor.black,
          // padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          textStyle: textStyle ?? AppTextStyles.bold13(/*color: UtilsMethod().getColorBasedOnTheme(context)*/),
        ),
        onPressed: onTap,
        child: AutoSizeText(
          btnText!,
          maxLines: 1,
        ),
      ),
    );
  }
}
