// import 'package:get/get.dart';
// import 'package:intellect_mutual_fund/my_app_exports.dart';
//
import 'package:flutter/material.dart';
import 'package:intellect_mutual_fund/my_app_exports.dart';

// class AppRoute {
//   static const String searchScreen = '/searchScreen';
//   static const String bestPerformingFundScreen = '/bestPerformingFundScreen';
//   static const String fundByUsScreen = '/fundByUsScreen';
//   static const String latestFundRelease = '/latestFundRelease';
//   static const String quickActionScreen = '/quickActionScreen';
//   static const String fundDetailScreen = '/fundDetailScreen';
//   static const String orderPlacementScreen = '/orderPlacementScreen';

// static List<GetPage> getPages() {
//   var args = Get.arguments; // declaration for simplicity
//   return [
//     GetPage(name: searchScreen, page: () => const SearchScreen()),
//     GetPage(name: bestPerformingFundScreen, page: () => const BestPerformingScreen()),
//     GetPage(name: fundByUsScreen, page: () => const FundByUsScreen()),
//     GetPage(name: latestFundRelease, page: () => const LatestFundReleaseScreen()),
//     GetPage(
//         name: quickActionScreen,
//         page: () => QuickActionScreen(
//               args: Get.arguments as QuickActionScreenArgs,
//             )),
//     GetPage(
//         name: fundDetailScreen,
//         page: () => FundDetailScreen(
//               args: Get.arguments as FundDetailScreenArgs,
//             )),
//     GetPage(
//         name: orderPlacementScreen,
//         page: () => OrderPlacementScreen(
//               args: Get.arguments as OrderPlacementScreenArgs,
//             )),
//   ];
// }
// }

class AppRoute {
  static const String searchScreen = '/searchScreen';
  static const String bestPerformingFundScreen = '/bestPerformingFundScreen';
  static const String fundByUsScreen = '/fundByUsScreen';
  static const String latestFundRelease = '/latestFundRelease';
  static const String quickActionScreen = '/quickActionScreen';
  static const String fundDetailScreen = '/fundDetailScreen';
  static const String orderPlacementScreen = '/orderPlacementScreen';

  static Route<dynamic> controller(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppRoute.searchScreen:
        return MaterialPageRoute(builder: (context) => SearchScreen());

      case AppRoute.fundByUsScreen:
        return MaterialPageRoute(
          builder: (context) => FundByUsScreen(),
        );
      case AppRoute.bestPerformingFundScreen:
        return MaterialPageRoute(
          builder: (context) => BestPerformingScreen(),
        );
      case AppRoute.latestFundRelease:
        return MaterialPageRoute(
          builder: (context) => LatestFundReleaseScreen(),
        );

      case AppRoute.quickActionScreen:
        return MaterialPageRoute(
          builder: (context) => QuickActionScreen(args: args as QuickActionScreenArgs),
        );

      case AppRoute.fundDetailScreen:
        return MaterialPageRoute(
          builder: (context) => FundDetailScreen(args: args as FundDetailScreenArgs),
        );

      case AppRoute.orderPlacementScreen:
        return MaterialPageRoute(
          builder: (context) => OrderPlacementScreen(args: args as OrderPlacementScreenArgs),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text("Unknown Page"),
            ),
            body: Center(child: Text('No Page Found With This Name ${settings.name}')),
          ),
        );
    }
  }
}
