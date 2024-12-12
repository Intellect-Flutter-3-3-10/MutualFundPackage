import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellect_mutual_fund/my_app_exports.dart';

// void main() {
//   var mutualFundBaseUrl = 'https://trade.aionioncapital.com/test/MutulFunds/api/v1';
//   runApp(
//     MutualFund(
//       themeMode: ThemeMode.system,
//       // theme: ThemeData(useMaterial3: false),
//       postSipOrderEndPoint: '$mutualFundBaseUrl/SipOrders',
//       postOrdersEndPoint: '$mutualFundBaseUrl/Orders',
//       getExploreFundsEndPoint: '$mutualFundBaseUrl/ExploreFunds',
//       basUrlEndPoint: mutualFundBaseUrl,
//       getActiveOrdersEndPoint: '$mutualFundBaseUrl/Orders',
//       getFundOverViewEndPoint: '$mutualFundBaseUrl/GetFundOverview',
//       getFundOverViewCalInfoEndPoint: '$mutualFundBaseUrl/GetFundOverViewCalcInfo',
//       mPin: 111111,
//       userName: 'Sundar',
//       clientCode: 123456,
//     ),
//   );
// }

class MutualFund extends StatefulWidget {
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode? themeMode;

  // final ApiEndPoints apiEndPoints;

  final String basUrlEndPoint;
  final String getExploreFundsEndPoint;
  final String postOrdersEndPoint;
  final String getActiveOrdersEndPoint;
  final String postSipOrderEndPoint;
  final String getFundOverViewEndPoint;
  final String getFundOverViewCalInfoEndPoint;

  // final UserData userData;

  final int clientCode;
  final int mPin;
  final String userName;

  const MutualFund({
    this.theme,
    this.darkTheme,
    this.themeMode,
    // required this.apiEndPoints,
    // required this.userData,
    required this.clientCode,
    required this.userName,
    required this.mPin,
    required this.basUrlEndPoint,
    required this.getExploreFundsEndPoint,
    required this.postOrdersEndPoint,
    required this.getActiveOrdersEndPoint,
    required this.postSipOrderEndPoint,
    required this.getFundOverViewEndPoint,
    required this.getFundOverViewCalInfoEndPoint,
  });

  @override
  State<MutualFund> createState() => _MutualFundState();
}

class _MutualFundState extends State<MutualFund> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();
    final GlobalController globalController = Get.put(GlobalController());
    var mutualFundBaseUrl = 'https://trade.aionioncapital.com/test/MutulFunds/api/v1';

    globalController.setApiEndpoints(
      baseurl: widget.basUrlEndPoint,
      exploreFund: widget.getExploreFundsEndPoint,
      postOrder: widget.postOrdersEndPoint,
      postSipOrder: widget.postSipOrderEndPoint,
      activeOrders: widget.getActiveOrdersEndPoint,
      fundOverview: widget.getFundOverViewEndPoint,
      fundOverviewCalInfo: widget.getFundOverViewCalInfoEndPoint,
    );

    globalController.setUserData(
      clientcode: widget.clientCode,
      mpin: widget.mPin,
      userName: widget.userName,
    );

    globalController.checkDetails();

    return GetMaterialApp(
      title: 'Mutual Funds App',
      getPages: AppRoute.getPages(),
      debugShowCheckedModeBanner: false,
      theme: widget.theme ?? AppTheme.lightTheme,
      darkTheme: widget.darkTheme ?? AppTheme.darkTheme,
      themeMode: widget.themeMode ?? AppTheme.systemThemeMode,
      home: DashBoardScreen(
        // themeMode: ThemeMode.system,
        // theme: ThemeData(useMaterial3: false),
        postSipOrderEndPoint: '$mutualFundBaseUrl/SipOrders',
        postOrdersEndPoint: '$mutualFundBaseUrl/Orders',
        getExploreFundsEndPoint: '$mutualFundBaseUrl/ExploreFunds',
        basUrlEndPoint: mutualFundBaseUrl,
        getActiveOrdersEndPoint: '$mutualFundBaseUrl/Orders',
        getFundOverViewEndPoint: '$mutualFundBaseUrl/GetFundOverview',
        getFundOverViewCalInfoEndPoint: '$mutualFundBaseUrl/GetFundOverViewCalcInfo',
        mPin: 111111,
        userName: 'Sundar',
        clientCode: 123456,
      ),
    );
  }
}
