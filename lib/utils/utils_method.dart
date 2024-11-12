import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../my_app_exports.dart';

class UtilsMethod {
  // UtilsMethod._();

  // change color according to theme
  Color getColorBasedOnTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
  }

// bottom sheet
  void showBottomSheet({
    BuildContext? context,
    Widget? child,
  }) {
    // Size size = MediaQuery.of(context!).size;
    showModalBottomSheet(
      elevation: 10,
      isScrollControlled: true,
      enableDrag: true,
      context: context!,
      useSafeArea: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
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
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimens.appVPadding,
              horizontal: AppDimens.appHPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 5,
                  width: MediaQuery.of(context).size.width / 3.5,
                  decoration: BoxDecoration(
                      color: UtilsMethod().getColorBasedOnTheme(context),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100),
                      )),
                ),
                const SizedBox(height: AppDimens.appSpacing20),
                SizedBox(
                  child: child,
                ),
                const SizedBox(height: AppDimens.appSpacing10),
              ],
            ),
          ),
        );
      },
    );
  }
}
