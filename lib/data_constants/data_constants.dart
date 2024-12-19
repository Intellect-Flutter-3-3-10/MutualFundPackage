import 'package:get/get.dart';

import '../my_app_exports.dart';

class DataConstants {
  /// ======================= Dependency Injections =====================///
  static ExploreFundsController exploreFundsController = Get.put(ExploreFundsController());
  static FundDetailController fundDetailController = Get.put(FundDetailController());
  static GlobalController globalController = Get.put(GlobalController());
  static OrderPlaceController orderPlaceController = Get.put(OrderPlaceController());
  static OrdersController ordersController = Get.put(OrdersController());
  static SchemaSearchFilterController schemaSearchFilterController = Get.put(SchemaSearchFilterController());
  static WatchListController watchListController = Get.put(WatchListController());

  /// ======================= Dependency Injections =====================///
  List<String> watchList = [
    'Watchlist 1',
    'Watchlist 2',
    'Watchlist 3',
    'Watchlist 4',
  ];
}
