import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellect_mutual_fund/my_app_exports.dart';

void main() {
  runApp(const MutualFund());
}

class MutualFund extends StatelessWidget {
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode? themeMode;
  final String? basUrlEndPoint;
  final String? getExploreFundsEndPoint;
  final String? postOrdersEndPoint;
  final String? getOrdersEndPoint;
  final String? postSipOrderEndPoint;
  final int? clientCode;
  final int? mPin;
  final String? developer;

  const MutualFund({
    super.key,
    this.theme,
    this.darkTheme,
    this.themeMode,
    this.basUrlEndPoint,
    this.getExploreFundsEndPoint,
    this.postOrdersEndPoint,
    this.getOrdersEndPoint,
    this.postSipOrderEndPoint,
    this.clientCode,
    this.mPin,
    this.developer,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final GlobalController globalController = Get.put(GlobalController());

    globalController.setApiEndpoints(
      baseurl: basUrlEndPoint ?? 'N/A',
      exploreFund: getExploreFundsEndPoint ?? 'N/A',
      postOrder: postOrdersEndPoint ?? 'N/A',
      postSipOrder: postSipOrderEndPoint ?? "N/A",
      dev: developer ?? 'N/A',
    );

    globalController.setUserData(clientCode!, mPin!);
    return GetMaterialApp(
      title: 'Mutual Funds App',
      getPages: AppRoute.getPages(),
      debugShowCheckedModeBanner: false,
      theme: theme ?? AppTheme.lightTheme,
      darkTheme: darkTheme ?? AppTheme.darkTheme,
      themeMode: themeMode ?? AppTheme.systemThemeMode,
      home: const DashBoardScreen(),
    );
  }
}
