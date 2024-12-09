import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intellect_mutual_fund/res/app_colors.dart';
import 'package:intellect_mutual_fund/res/app_images.dart';

class CommonIconButton extends StatelessWidget {
  final String? pictureIcon;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final Function()? onTap;
  final bool isSvg;

  const CommonIconButton({
    super.key,
    this.pictureIcon= AppImage.saveIcon,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.onTap,
    this.isSvg = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: isSvg
          ? SvgPicture.asset(
              pictureIcon!,
              color: iconColor ?? AppColor.greyLight,
            )
          : Icon(
              icon,
              color: iconColor ?? AppColor.greyLight,
              size: iconSize ?? 24,
            ),
    );
  }
}
