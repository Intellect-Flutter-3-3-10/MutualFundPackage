library mutual_fund_package;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_app_exports.dart';

class MutualFundPackage extends StatefulWidget {
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode? themeMode;
  final String? basUrl;

  const MutualFundPackage({
    super.key,
    this.theme,
    this.darkTheme,
    this.themeMode,
    this.basUrl = 'www.google.com',
  });

  @override
  State<MutualFundPackage> createState() => _MutualFundPackageState();
}

class _MutualFundPackageState extends State<MutualFundPackage> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mutual Fund Package Module',
      getPages: AppRoute.getPages(),
      debugShowCheckedModeBanner: false,
      theme: widget.theme ?? AppTheme.lightTheme,
      darkTheme: widget.darkTheme ?? AppTheme.darkTheme,
      themeMode: widget.themeMode ?? AppTheme.systemThemeMode,
      home: const DashBoardScreen(),
    );
  }
}
// check git permission
