import 'package:get/get.dart';

import '../my_app_exports.dart';

class AppRoute {
  static const String searchScreen = '/searchScreen';
  static const String bestPerformingFundScreen = '/bestPerformingFundScreen';
  static const String fundByUsScreen = '/fundByUsScreen';
  static const String latestFundRelease = '/latestFundRelease';
  static const String quickActionScreen = '/quickActionScreen';
  static const String fundDetailScreen = '/fundDetailScreen';
  static const String orderPlacementScreen = '/orderPlacementScreen';

  static List<GetPage> getPages() {
    return [
      GetPage(name: searchScreen, page: () => const SearchScreen()),
      GetPage(name: bestPerformingFundScreen, page: () => const BestPerformingScreen()),
      GetPage(name: fundByUsScreen, page: () => const FundByUsScreen()),
      GetPage(name: latestFundRelease, page: () => const LatestFundReleaseScreen()),
      GetPage(
          name: quickActionScreen,
          page: () => QuickActionScreen(
                args: Get.arguments as QuickActionScreenArgs,
              )),
      GetPage(name: fundDetailScreen, page: () => const FundDetailScreen()),
      GetPage(
          name: orderPlacementScreen,
          page: () => OrderPlacementScreen(
                args: Get.arguments as OrderPlacementScreenArgs,
              )),
    ];
  }
}
