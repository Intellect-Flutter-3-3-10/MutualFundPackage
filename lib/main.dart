import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellect_mutual_fund/my_app_exports.dart';
import 'package:intellect_mutual_fund/routes/routes.dart' as route;

void main() {
  var mutualFundBaseUrl = 'https://trade.aionioncapital.com/test/MutulFunds/api/v1';
  runApp(
    MaterialApp(
      // routes: route.AppRoute.controller,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: route.AppRoute.controller,
      home: MutualFund(
        themeMode: ThemeMode.system,
        // theme: ThemeData(useMaterial3: false),
        postSipOrderEndPoint: '$mutualFundBaseUrl/SipOrders',
        postOrdersEndPoint: '$mutualFundBaseUrl/Orders',
        getExploreFundsEndPoint: '$mutualFundBaseUrl/ExploreFunds',
        basUrlEndPoint: mutualFundBaseUrl,
        getActiveOrdersEndPoint: '$mutualFundBaseUrl/Orders',
        getFundOverViewEndPoint: '$mutualFundBaseUrl/GetFundOverview',
        getFundOverViewCalInfoEndPoint: '$mutualFundBaseUrl/GetFundOverViewCalcInfo',
        clientCode: 1234,
        mPin: 111111,
        userName: 'Sundar',
        addToWatchListEndPoint: 'https://trade.aionioncapital.com/test/MfWatchList/api/v1/MfWatchList',
        getWatchListEndPoint: 'https://trade.aionioncapital.com/test/MfWatchList/api/v1/MfWatchList',
        deleteWatchListEndPoint: 'https://trade.aionioncapital.com/test/MfWatchList/api/v1/MfWatchList',
        // scaffoldKey: scaffoldKey,
        // scaffoldKey: null,
      ),
    ),
  );
}

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
  final String addToWatchListEndPoint;
  final String getWatchListEndPoint;
  final String deleteWatchListEndPoint;

  // final UserData userData;

  final int clientCode;
  final int mPin;
  final String userName;

  final GlobalKey<NavigatorState>? navigatorKey;
  final GlobalKey<ScaffoldMessengerState>? scaffoldKey;

  MutualFund({
    this.scaffoldKey,
    this.navigatorKey,
    this.darkTheme,
    this.themeMode,
    this.theme,
    // required this.navigatorKey,
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
    required this.addToWatchListEndPoint,
    required this.getWatchListEndPoint,
    required this.deleteWatchListEndPoint,
  });

  @override
  State<MutualFund> createState() => _MutualFundState();
}

class _MutualFundState extends State<MutualFund> {
  @override
  Widget build(BuildContext context) {
    final GlobalController globalController = Get.put(GlobalController());

    globalController.setApiEndpoints(
      baseurl: widget.basUrlEndPoint,
      exploreFund: widget.getExploreFundsEndPoint,
      postOrder: widget.postOrdersEndPoint,
      postSipOrder: widget.postSipOrderEndPoint,
      activeOrders: widget.getActiveOrdersEndPoint,
      fundOverview: widget.getFundOverViewEndPoint,
      fundOverviewCalInfo: widget.getFundOverViewCalInfoEndPoint,
      navigatorkey: widget.navigatorKey,
      scaffoldkey: widget.scaffoldKey,
      AddToWatchlist: widget.addToWatchListEndPoint,
      GetWatchlist: widget.getWatchListEndPoint,
      DeleteWatchlist: widget.deleteWatchListEndPoint,
    );

    globalController.setUserData(
      clientcode: widget.clientCode,
      mpin: widget.mPin,
      userName: widget.userName,
    );

    globalController.checkDetails();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: route.AppRoute.controller,
      home: DashBoardScreen(),
    );
  }

  @override
  void dispose() {
    Get.delete<GlobalController>();
    super.dispose();
  }
}
