import 'package:flutter/material.dart';

import '../res/res.dart';
// import 'package:intellect_mutual_fund/my_app_exports.dart';

class AppTheme {
  // Light Theme

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    cardColor: AppColor.white,
    canvasColor: AppColor.white,
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: AppColor.white, surfaceTintColor: AppColor.white),
    tabBarTheme: TabBarTheme(
      labelColor: AppColor.black,
      unselectedLabelColor: AppColor.greyLightest,
      indicatorColor: AppColor.black,
      dividerColor: Colors.transparent,

      // unselectedLabelColor: AppColor.grey300,
      // labelColor: Colors.black,
      // indicatorColor: Colors.black,
      unselectedLabelStyle: AppTextStyles.regular15(
          // color: UtilsMethod().getColorBasedOnTheme(context),
          ),
      labelStyle: AppTextStyles.semiBold15(
          // color: UtilsMethod().getColorBasedOnTheme(BuildContext? context),
          ),
    ),
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    // textTheme: const TextTheme(
    //   bodyLarge: TextStyle(color: Colors.black),
    //   bodyMedium: TextStyle(color: Colors.black),
    //   displayLarge: TextStyle(color: Colors.black),
    //   displayMedium: TextStyle(color: Colors.black),
    //   displaySmall: TextStyle(color: Colors.black),
    //   headlineMedium: TextStyle(color: Colors.black),
    //   headlineSmall: TextStyle(color: Colors.black),
    //   titleLarge: TextStyle(color: Colors.black),
    //   titleMedium: TextStyle(color: Colors.black),
    //   titleSmall: TextStyle(color: Colors.black),
    //   labelLarge: TextStyle(color: Colors.black),
    // ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.black, // Use a darker button color for contrast
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: false,
      // fillColor: Colors.grey.shade200,
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: AppColor.black, surfaceTintColor: AppColor.black),
    cardColor: AppColor.black,
    canvasColor: AppColor.black,
    tabBarTheme: TabBarTheme(
      labelColor: AppColor.white,
      unselectedLabelColor: AppColor.greyLightest,
      indicatorColor: AppColor.white,
      unselectedLabelStyle: AppTextStyles.regular15(
          // color: UtilsMethod().getColorBasedOnTheme(context),
          ),
      labelStyle: AppTextStyles.semiBold15(
          // color: UtilsMethod().getColorBasedOnTheme(BuildContext? context),
          ),
    ),
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    // textTheme: TextTheme(
    //   bodyLarge: TextStyle(color: Colors.white),
    //   bodyMedium: TextStyle(color: Colors.white),
    //   displayLarge: TextStyle(color: Colors.white),
    //   displayMedium: TextStyle(color: Colors.white),
    //   displaySmall: TextStyle(color: Colors.white),
    //   headlineMedium: TextStyle(color: Colors.white),
    //   headlineSmall: TextStyle(color: Colors.white),
    //   titleLarge: TextStyle(color: Colors.white),
    //   titleMedium: TextStyle(color: Colors.white),
    //   titleSmall: TextStyle(color: Colors.white),
    //   labelLarge: TextStyle(color: Colors.white),
    // ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.white, // Use a lighter button color for contrast
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: false,
      // fillColor: Colors.grey.shade800,
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    ),
  );

  // Theme mode to support system preference
  static ThemeMode systemThemeMode = ThemeMode.system;

  // A method to get the current theme based on user preference
  static ThemeData getTheme(BuildContext context, bool isDarkMode) {
    return isDarkMode ? darkTheme : lightTheme;
  }
}
