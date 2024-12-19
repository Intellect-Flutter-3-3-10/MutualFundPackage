import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../../my_app_exports.dart';

class ExploreFundsController extends GetxController {
  final Logger logger = Logger();

  RxList<FundData> exploreFundList = <FundData>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchExploreFunds();
  }

  Future<void> fetchExploreFunds() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(
        DataConstants.globalController.getExploreFunds,
      ));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        ExploreFundsModel fundModel = ExploreFundsModel.fromJson(jsonData);
        if (fundModel.status == true) {
          exploreFundList.value = fundModel.data ?? [];
          DataConstants.watchListController.filterFundsFromWatchlist();
          markFundsInWatchList();
        } else {
          errorMessage.value = fundModel.message!;
        }
      } else {
        errorMessage.value = 'Error Failed to fetch data';
      }
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      isLoading(false);
    }
  }

  void markFundsInWatchList() {
    // Get the filtered fund scheme codes from the watchlist
    var watchListSchemeCodes = DataConstants.watchListController.filteredFundList.map((fund) => fund.schemeCode).toSet();

    // Update the exploreFundList with the `isInWatchList` property
    exploreFundList.value = exploreFundList.map((fund) {
      bool isInWatchList = watchListSchemeCodes.contains(fund.schemeCode);
      return fund.copyWith(isInWatchList: isInWatchList);
    }).toList();

    // Debugging
    print(
        "Updated exploreFundList with isInWatchList: ${exploreFundList.map((fund) => 'Scheme: ${fund.schemeCode}, IsInWatchList: ${fund.isInWatchList}').toList()}");
  }
}
