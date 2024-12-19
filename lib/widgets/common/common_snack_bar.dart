import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellect_mutual_fund/my_app_exports.dart';

enum SnackBarType { success, failure, warning }

class CommonSnackBar {
  static void showSnackBar({
    String? title,
    String? message,
    required SnackBarType type,
  }) {
    Color backgroundColor;

    // Set colors based on the enum type
    switch (type) {
      case SnackBarType.success:
        backgroundColor = AppColor.green;
        break;
      case SnackBarType.failure:
        backgroundColor = AppColor.red;
        break;
      case SnackBarType.warning:
        backgroundColor = AppColor.lightAmber;
        break;
    }

    Get.snackbar(
      title ?? 'N/A',
      message ?? 'N/A',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
    );
  }
}
