import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../my_app_exports.dart';
import '../res/res.dart';

class ShowRatingWidget extends StatelessWidget {
  final String? rating;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final double? ratingSize;

  const ShowRatingWidget({
    super.key,
    this.rating = '0',
    this.icon = Icons.star,
    this.iconColor = Colors.yellow,
    this.iconSize,
    this.ratingSize = 13,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AutoSizeText(
          rating!,
          style: AppTextStyles.regular13(
            color: UtilsMethod().getColorBasedOnTheme(context),
          ),
          maxLines: 1,
        ),
        Icon(
          Icons.star,
          color: iconColor,
          size: iconSize ?? 24,
        )
      ],
    );
  }
}
