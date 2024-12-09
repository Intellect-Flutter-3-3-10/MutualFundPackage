import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellect_mutual_fund/my_app_exports.dart';

void main() {
  var mutualFundBaseUrl = 'https://trade.aionioncapital.com/test/MutulFunds/api/v1';
  runApp(MutualFund(
    themeMode: ThemeMode.system,
    postSipOrderEndPoint: '$mutualFundBaseUrl/SipOrders',
    postOrdersEndPoint: '$mutualFundBaseUrl/Orders',
    getExploreFundsEndPoint: '$mutualFundBaseUrl/ExploreFunds',
    developer: 'Sundar',
    clientCode: 123456,
    mPin: 111111,
    basUrlEndPoint: mutualFundBaseUrl,
    getActiveOrdersEndPoint: '$mutualFundBaseUrl/Orders',
  ));
}

class MutualFund extends StatelessWidget {
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode? themeMode;
  final String basUrlEndPoint;
  final String getExploreFundsEndPoint;
  final String postOrdersEndPoint;

  final String getActiveOrdersEndPoint;
  final String postSipOrderEndPoint;
  final int clientCode;
  final int mPin;
  final String developer;

  const MutualFund({
    super.key,
    this.theme,
    this.darkTheme,
    this.themeMode,
    required this.basUrlEndPoint,
    required this.getExploreFundsEndPoint,
    required this.postOrdersEndPoint,
    required this.getActiveOrdersEndPoint,
    required this.postSipOrderEndPoint,
    required this.clientCode,
    required this.mPin,
    required this.developer,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize GlobalController
    final GlobalController globalController = Get.put(GlobalController());

    // Set data in GlobalController
    globalController.setApiEndpoints(
      baseurl: basUrlEndPoint,
      exploreFund: getExploreFundsEndPoint,
      postOrder: postOrdersEndPoint,
      postSipOrder: postSipOrderEndPoint,
      dev: developer,
      activeOrders: getActiveOrdersEndPoint,
    );
    globalController.setUserData(clientCode, mPin);

    // Logging values for debugging
    globalController.checkDetails();

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
