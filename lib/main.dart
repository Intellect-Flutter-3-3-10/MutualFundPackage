import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellect_mutual_fund/my_app_exports.dart';

void main() {
  runApp(const MutualFund());
}

class MutualFund extends StatefulWidget {
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

  @override
  State<MutualFund> createState() => _MutualFundState();
}

class _MutualFundState extends State<MutualFund> {
  late GlobalController globalController = Get.put(GlobalController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    globalController;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final GlobalController globalController = Get.put(GlobalController());

    globalController.setApiEndpoints(
      baseurl: widget.basUrlEndPoint ?? 'N/A',
      exploreFund: widget.getExploreFundsEndPoint ?? 'N/A',
      postOrder: widget.postOrdersEndPoint ?? 'N/A',
      postSipOrder: widget.postSipOrderEndPoint ?? "N/A",
      dev: widget.developer ?? 'N/A',
    );

    globalController.setUserData(widget.clientCode!, widget.mPin!);
    return GetMaterialApp(
      title: 'Mutual Funds App',
      getPages: AppRoute.getPages(),
      debugShowCheckedModeBanner: false,
      theme: widget.theme ?? AppTheme.lightTheme,
      darkTheme: widget.darkTheme ?? AppTheme.darkTheme,
      themeMode: widget.themeMode ?? AppTheme.systemThemeMode,
      home: const DashBoardScreen(),
    );
  }
}
