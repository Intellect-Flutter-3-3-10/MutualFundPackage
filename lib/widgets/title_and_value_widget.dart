import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../res/res.dart';
import '../utils/utils.dart';

class TitleAndValueWidget extends StatelessWidget {
  final CrossAxisAlignment? crossAxisAlignment;
  final String? title;
  final String? value;
  final Color? valueColor;
  final Color? iconColor;
  final double? titleSize;
  final double? valueSize;
  final double? iconSize;
  final IconData? icon;
  final bool isHorizontal;
  final bool isLeadingIcon;
  final bool isValueWidget;
  final Widget? valueWidget;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  const TitleAndValueWidget({
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.title = 'Title',
    this.value = 'Values',
    this.titleSize = 12,
    this.valueSize = 15,
    this.valueColor,
    this.isHorizontal = false,
    this.isLeadingIcon = false,
    this.iconColor = AppColor.greyLight,
    this.icon = Icons.insert_emoticon,
    this.iconSize = 24,
    this.titleStyle,
    this.valueStyle,
    this.isValueWidget = false,
    this.valueWidget,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTitleStyle = AppTextStyles.regular12(color: AppColor.greyLightest);
    final defaultValueStyle = AppTextStyles.semiBold15(
      color: valueColor ?? UtilsMethod().getColorBasedOnTheme(context),
    );

    return isHorizontal
        ? FittedBox(
            child: Row(
              children: [
                if (isLeadingIcon)
                  Icon(
                    icon,
                    color: iconColor,
                    size: iconSize,
                  ),
                AutoSizeText(
                  "$title:",
                  style: titleStyle ?? defaultTitleStyle,
                  maxLines: 1,
                ),
                const SizedBox(width: AppDimens.appSpacing5),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: AutoSizeText(
                    "$value",
                    style: valueStyle ?? defaultValueStyle,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          )
        : Column(
            crossAxisAlignment: crossAxisAlignment!,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AutoSizeText(
                title!,
                style: titleStyle ?? defaultTitleStyle,
                maxLines: 1,
              ),
              isValueWidget
                  ? SizedBox(
                      child: valueWidget,
                      // value widget
                    )
                  : AutoSizeText(
                      value!,
                      style: valueStyle ?? defaultValueStyle,
                      maxLines: 1,
                    ),
            ],
          );
  }
}
