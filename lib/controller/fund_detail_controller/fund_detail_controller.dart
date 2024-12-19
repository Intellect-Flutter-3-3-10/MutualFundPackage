import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellect_mutual_fund/utils/get_storage_data.dart';
import '../../my_app_exports.dart';
import 'package:http/http.dart' as http;

class FundDetailController extends GetxController {
  final globalController = Get.find<GlobalController>(); // This remains as is.

  static Rx<GetMutualFundOverviewModel> mutualFundData = GetMutualFundOverviewModel().obs;

  static RxList<HistoricalNavDetail> historicalNAVDetails = <HistoricalNavDetail>[].obs;

  static RxList<HistoricalNavDetail> filteredNAVDetails = <HistoricalNavDetail>[].obs;

  static RxList<ChartPeriod> chartPeriods = <ChartPeriod>[].obs;

  var fundOverviewCalInfoData = FundOverviewCalInfoModel().obs;

  RxBool isLoading = false.obs;
  RxBool isCalInfoLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxString errorMessageCalInfo = ''.obs;

  // The current selected period ID (default is "ALL")
  var selectedPeriodId = "ALL".obs;
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    DataConstants.watchListController.fetchWatchList(userId: DataConstants.globalController.clientCode.toString());
    // Initial filtering with "ALL"
    filterChartData("ALL");

    // Automatically filter whenever historicalNAVDetails changes
    ever(historicalNAVDetails, (_) {
      filterChartData(selectedPeriodId.value);
    });

    // Automatically filter whenever the selected period changes
    ever(selectedPeriodId, (newPeriodId) {
      filterChartData(newPeriodId);
    });
  }

  Future<void> fetchMutualFundOverview({required String schemeCode}) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final url = Uri.parse(globalController.getFundOverview); // API endpoint

      // Define headers
      final headers = {
        "Content-Type": "application/json",
      };

      // Define request body
      final body = jsonEncode({
        "schemeCode": schemeCode,
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse["status"] == true) {
          DataConstants.watchListController.filterFundsFromWatchlist();
          // Parse and store the data in the model
          // mutualFundData.value = getMutualFundOverviewModelFromJson(response.body);
          mutualFundData.value = GetMutualFundOverviewModel.fromJson(jsonResponse);
          historicalNAVDetails.value = mutualFundData.value.data!.historicalNavDetails!;
          chartPeriods.value = mutualFundData.value.data!.chartPeriods!;

          /// Check if the schemeCode exists in filteredFundList
          final matchingFund = DataConstants.watchListController.filteredFundList
              .firstWhereOrNull((fund) => fund.schemeCode.toString() == mutualFundData.value.data?.schemeCode.toString());

          /// Extract isInWatchlist and rating
          final isInWatchlist = matchingFund != null;
          final rating = matchingFund?.rating ?? 0.0;
          final id = matchingFund?.id ?? 0;

          /// Use copyWith to update the isInWatchlist flag and rating
          mutualFundData.value = mutualFundData.value.copyWith(
            data: mutualFundData.value.data!.copyWith(
              isInWatchlist: isInWatchlist,
              rating: rating.toString(),
              id: id,
            ),
          );

          debugPrint("Mutual Fund Data: ${mutualFundData}");
        } else {
          errorMessage.value = jsonResponse["message"] ?? "Failed to fetch data.";
        }
      } else {
        errorMessage.value = "Server Error: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = "An error occurred: $e";
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

  Future<void> fetchFundOverviewCalInfo({
    required String schemeCode,
    required String investmentType,
    required String investedAmount,
  }) async {
    final url = Uri.parse(globalController.getFundOverViewCalcInfo);

    final body = {
      "schemeCode": schemeCode,
      "investmentType": investmentType,
      "investedAmount": investedAmount,
    };

    try {
      isCalInfoLoading.value = true;

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == true) {
          fundOverviewCalInfoData.value = FundOverviewCalInfoModel.fromJson(jsonResponse['data']);
        } else {
          errorMessageCalInfo.value = jsonResponse['message'];
          // Get.snackbar('Error', jsonResponse['message'] ?? 'Unknown error');
        }
      } else {
        errorMessageCalInfo.value = 'Error : Failed to fetch data. Please try again.';
        // Get.snackbar('Error', 'Failed to fetch data. Please try again.');
      }
    } catch (e) {
      errorMessageCalInfo.value = 'Error An error occurred: $e';
      // Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isCalInfoLoading.value = false;
    }
  }

  // Filter chart data based on the selected period
  void filterChartData(String periodId) {
    debugPrint("Filtering data for period: $periodId");

    if (periodId == "ALL") {
      // Show all data
      filteredNAVDetails.value = List.from(historicalNAVDetails);
      debugPrint("Filtered Data (ALL): ${filteredNAVDetails.length}");
      return;
    }

    // Get the current date
    DateTime now = DateTime.now();

    // Calculate the cutoff date
    DateTime cutoffDate;
    switch (periodId) {
      case "1M":
        cutoffDate = now.subtract(const Duration(days: 30));
        break;
      case "6M":
        cutoffDate = now.subtract(const Duration(days: 182)); // Approx 6 months
        break;
      case "1Y":
        cutoffDate = now.subtract(const Duration(days: 365)); // Approx 1 year
        break;
      case "3Y":
        cutoffDate = now.subtract(const Duration(days: 1095)); // Approx 3 years
        break;
      case "5Y":
        cutoffDate = now.subtract(const Duration(days: 1825)); // Approx 5 years
        break;
      default:
        filteredNAVDetails.value = List.from(historicalNAVDetails);
        debugPrint("Filtered Data (Default): ${filteredNAVDetails.length}");
        return;
    }

    // Filter the historicalNAVDetails list
    filteredNAVDetails.value = historicalNAVDetails.where((detail) => DateTime.parse(detail.navDate.toString()).isAfter(cutoffDate)).toList();

    // Debug log for filtered data
    debugPrint("Filtered Data (${periodId}): ${filteredNAVDetails.length}");
  }

  // Call this when toggling between periods
  void selectPeriod(String periodId) {
    selectedPeriodId.value = periodId;
  }

  void onPeriodToggle(int index) {
    // Update the selected index
    selectedIndex.value = index;

    // Get the corresponding period ID and filter data
    final periodId = chartPeriods[index].periodName;
    filterChartData(periodId);

    debugPrint('Selected Period: $periodId');
    debugPrint('Filtered Data: ${filteredNAVDetails.length}');
  }
}
// /// Check if schemeCode exists in filteredFundList
//           bool isInWatchlist = DataConstants.watchListController.filteredFundList
//               .any((fund) => fund.schemeCode.toString() == mutualFundData.value.data!.schemeCode.toString());
//
//           /// Set isInWatchlist flag in mutualFundData
//           mutualFundData.value.data!.isInWatchlist = isInWatchlist;
