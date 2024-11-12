import 'package:flutter/material.dart';

import '../../res/res.dart';

class CommonOutLinedContainer extends StatelessWidget {
  final Widget? child;
  final Color? bgColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? vPadding;
  final double? hPadding;

  const CommonOutLinedContainer({
    super.key,
    this.child,
    this.bgColor = AppColor.lightestAmber,
    this.borderColor = AppColor.lightestAmber,
    this.vPadding = AppDimens.appSpacing15,
    this.hPadding = AppDimens.appSpacing15,
    this.borderRadius = AppDimens.appRadius12,
  });

  @override
  Widget build(BuildContext context) {
    var tColor = Theme.of(context).scaffoldBackgroundColor;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: hPadding!,
        vertical: vPadding!,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor!, width: 0.8),
        borderRadius: BorderRadius.circular(borderRadius!),
        color: bgColor?? tColor,
      ),
      child: child,
    );
  }
}
