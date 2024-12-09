import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intellect_mutual_fund/widgets/widgets.dart';

import '../res/res.dart';

class CustomDateChip extends StatelessWidget {
  final String? date;
  final String? month;
  final Color? bgColor;

  const CustomDateChip({super.key, this.date, this.month, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return CommonOutLinedContainer(
      borderColor: AppColor.greyLight,
      bgColor: bgColor ?? Theme.of(context).scaffoldBackgroundColor,
      hPadding: AppDimens.appSpacing5,
      vPadding: AppDimens.appSpacing5,
      borderRadius: AppDimens.appRadius6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText(
            date ?? "N/A",
            style: AppTextStyles.regular13(),
            maxLines: 1,
          ),
          AutoSizeText(
            month ?? "N/A",
            style: AppTextStyles.regular15(),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
