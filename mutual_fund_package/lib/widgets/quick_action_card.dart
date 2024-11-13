import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../my_app_exports.dart';

class QuickActionCard extends StatelessWidget {
  final String? image;
  final String? label;
  final Function()? onTap;
  final Color? bgColor;

  const QuickActionCard({super.key, this.image, this.label, this.onTap, this.bgColor});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // bool isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: UtilsMethod().getColorBasedOnTheme(context).withOpacity(0.1), // Shadow color
              offset: const Offset(-1, 1), // Positioning shadow from bottom right to top left
              blurRadius: 3, // Blur radius
              spreadRadius: 1, // Spread radius
            ),
            BoxShadow(
              color: UtilsMethod().getColorBasedOnTheme(context).withOpacity(0.1), // Shadow color
              offset: const Offset(1, -1), // Positioning shadow from bottom right to top left
              blurRadius: 3, // Blur radius
              spreadRadius: 2, // Spread radius
            ),
          ],
          color: bgColor ?? Theme.of(context).scaffoldBackgroundColor, // Background color for the container
          borderRadius: BorderRadius.circular(12), // Optional: for rounded corners
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.030, vertical: size.height * 0.005),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                image!,
                height: size.height * 0.040,
                width: size.width * 0.040,
              ),
              FittedBox(
                child: AutoSizeText(
                  label!,
                  style: AppTextStyles.regular12(
                    color: UtilsMethod().getColorBasedOnTheme(context),
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
