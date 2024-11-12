import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intellect_mutual_fund/res/res.dart';

import '../../my_app_exports.dart';

class CommonHeader extends StatelessWidget {
  final String? title;
  final String? actionLabel;
  final Function()? labelOnTap;
  final Color? labelColor;
  final Color? titleColor;
  final bool isTrailingIcon;
  final bool isActionLabel;
  final TextStyle? titleStyle;

  const CommonHeader({
    super.key,
    this.title = 'Title',
    this.actionLabel = AppString.viewAll,
    this.labelOnTap,
    this.labelColor = AppColor.blue,
    this.isTrailingIcon = false,
    this.titleStyle,
    this.titleColor,
    this.isActionLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(
          title!,
          style: titleStyle ??
              AppTextStyles.semiBold16(
                color: titleColor ?? UtilsMethod().getColorBasedOnTheme(context),
              ),
          maxLines: 1,
        ),
        isActionLabel
            ? Row(
                children: [
                  TextButton(
                    onPressed: labelOnTap,
                    child: AutoSizeText(
                      actionLabel!,
                      style: AppTextStyles.regular13(
                        color: labelColor ?? UtilsMethod().getColorBasedOnTheme(context),
                      ),
                      maxLines: 1,
                    ),
                  ),
                  isTrailingIcon ? SvgPicture.asset(AppImage.sortIcon) : const SizedBox.shrink(),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
