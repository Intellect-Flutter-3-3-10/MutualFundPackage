import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellect_mutual_fund/my_app_exports.dart';

void main() {
  var mutualFundBaseUrl = 'https://trade.aionioncapital.com/test/MutulFunds/api/v1';
  runApp(MutualFund(
    themeMode: ThemeMode.system,
    // postSipOrderEndPoint: '$mutualFundBaseUrl/SipOrders',
    // postOrdersEndPoint: '$mutualFundBaseUrl/Orders',
    // getExploreFundsEndPoint: '$mutualFundBaseUrl/ExploreFunds',
    // developer: 'Sundar',
    // clientCode: 123456,
    // mPin: 111111,
    // basUrlEndPoint: mutualFundBaseUrl,
    // getActiveOrdersEndPoint: '$mutualFundBaseUrl/Orders',
    apiEndPoints: ApiEndPoints(
      postSipOrderEndPoint: '$mutualFundBaseUrl/SipOrders',
      postOrdersEndPoint: '$mutualFundBaseUrl/Orders',
      getExploreFundsEndPoint: '$mutualFundBaseUrl/ExploreFunds',
      basUrlEndPoint: mutualFundBaseUrl,
      getActiveOrdersEndPoint: '$mutualFundBaseUrl/Orders',
    ),
    userData: UserData(
      userName: 'Sundar',
      clientCode: 123456,
      mPin: 111111,
    ),
  ));
}

class MutualFund extends StatelessWidget {
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode? themeMode;
  final ApiEndPoints apiEndPoints;

  // final String basUrlEndPoint;
  // final String getExploreFundsEndPoint;
  // final String postOrdersEndPoint;
  // final String getActiveOrdersEndPoint;
  // final String postSipOrderEndPoint;
  final UserData userData;

  // final int clientCode;
  // final int mPin;
  // final String userName;

  const MutualFund({
    super.key,
    this.theme,
    this.darkTheme,
    this.themeMode,
    required this.apiEndPoints,
    required this.userData,
    // required this.clientCode,
    // required this.developer,
    // required this.mPin,
    // required this.basUrlEndPoint,
    // required this.getExploreFundsEndPoint,
    // required this.postOrdersEndPoint,
    // required this.getActiveOrdersEndPoint,
    // required this.postSipOrderEndPoint,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalController globalController = Get.put(GlobalController());

    globalController.setApiEndpoints(
      baseurl: apiEndPoints.basUrlEndPoint,
      exploreFund: apiEndPoints.getExploreFundsEndPoint,
      postOrder: apiEndPoints.postOrdersEndPoint,
      postSipOrder: apiEndPoints.postSipOrderEndPoint,
      activeOrders: apiEndPoints.getActiveOrdersEndPoint,
    );

    globalController.setUserData(
      userData.clientCode,
      userData.mPin,
      userData.userName,
    );

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
