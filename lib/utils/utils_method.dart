import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../my_app_exports.dart';

class UtilsMethod {
  // UtilsMethod._();

  Future navigateTo(BuildContext context, String destination, {Object? args}) {
    return Navigator.pushNamed(context, destination, arguments: args);
  }

  Future<R?> navigateToWithReturnData<R>(BuildContext context, String destination, {Object? args}) {
    return Navigator.pushNamed<R>(context, destination, arguments: args);
  }

  Future replaceWith(BuildContext context, String destination, {dynamic args}) {
    return Navigator.pushReplacementNamed(context, destination, arguments: args);
  }

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

  void showPopUpModal({BuildContext? context, Widget? child, String? title}) {
    showDialog(
      context: context!,
      useRootNavigator: false,
      builder: (context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,

          // scrollable: from,
          title: Text(
            title ?? '',
            style: AppTextStyles.semiBold16(),
          ),
          content: child!,
        );
      },
    );
  }

  showToast(String msg, ToastType type) {
    var bgColor = Colors.white12;
    var txtColor = Colors.black;

    switch (type) {
      case ToastType.success:
        bgColor = Colors.green;
        txtColor = Colors.white;
        break;
      case ToastType.error:
        bgColor = Colors.red;
        txtColor = Colors.white;
        break;
      case ToastType.warning:
        bgColor = Colors.orange;
        txtColor = Colors.white;
        break;
      case ToastType.info:
        bgColor = Colors.white;
        txtColor = Colors.black;
        break;
    }

    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor,
      textColor: txtColor,
      fontSize: 16.0,
    );
  }
}

enum ToastType { success, error, warning, info }

class SnackbarHelper {
  // Function to show the snackbar
  static void showSnackbar({
    required BuildContext context,
    required String message,
    String? actionLabel,
    bool? showCloseIcon = false,
    VoidCallback? onActionPressed,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: showCloseIcon,
        content: Text(message),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColor.black.withOpacity(0.5),
        action: actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                onPressed: onActionPressed ?? () {},
              )
            : null,
      ),
    );
  }
}
