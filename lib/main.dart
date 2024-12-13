import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellect_mutual_fund/my_app_exports.dart';
import 'package:intellect_mutual_fund/routes/routes.dart' as route;

// void main() {
//   var mutualFundBaseUrl = 'https://trade.aionioncapital.com/test/MutulFunds/api/v1';
//   runApp(
//     MaterialApp(
//       // routes: route.AppRoute.controller,
//       onGenerateRoute: route.AppRoute.controller,
//       home: MutualFund(
//         themeMode: ThemeMode.system,
//         // theme: ThemeData(useMaterial3: false),
//         postSipOrderEndPoint: '$mutualFundBaseUrl/SipOrders',
//         postOrdersEndPoint: '$mutualFundBaseUrl/Orders',
//         getExploreFundsEndPoint: '$mutualFundBaseUrl/ExploreFunds',
//         basUrlEndPoint: mutualFundBaseUrl,
//         getActiveOrdersEndPoint: '$mutualFundBaseUrl/Orders',
//         getFundOverViewEndPoint: '$mutualFundBaseUrl/GetFundOverview',
//         getFundOverViewCalInfoEndPoint: '$mutualFundBaseUrl/GetFundOverViewCalcInfo',
//         mPin: 111111,
//         userName: 'Sundar',
//         clientCode: 123456,
//         // scaffoldKey: null,
//       ),
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

  final GlobalKey<NavigatorState>? navigatorKey;

  // final UserData userData;

  final int clientCode;
  final int mPin;
  final String userName;

  final GlobalKey<ScaffoldMessengerState> scaffoldKey;

  MutualFund({
    required this.scaffoldKey,
    required this.navigatorKey,
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

    return DashBoardScreen();
  }

  @override
  void dispose() {
    Get.delete<GlobalController>();
    super.dispose();
  }
}
