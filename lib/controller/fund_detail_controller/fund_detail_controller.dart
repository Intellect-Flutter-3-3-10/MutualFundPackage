import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../my_app_exports.dart';
import 'package:http/http.dart' as http;

class FundDetailController extends GetxController {
  final globalController = Get.find<GlobalController>(); // This remains as is.

  static Rx<GetMutualFundOverviewModel> mutualFundData = GetMutualFundOverviewModel().obs;

  static RxList<HistoricalNavDetail> historicalNAVDetails = <HistoricalNavDetail>[].obs;

  static RxList<ChartPeriod> chartPeriods = <ChartPeriod>[].obs;

  var fundOverviewCalInfoData = FundOverviewCalInfoModel().obs;

  RxBool isLoading = false.obs;
  RxBool isCalInfoLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxString errorMessageCalInfo = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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

      // Send POST request
      final response = await http.post(url, headers: headers, body: body);

      // Check if response is successful
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse["status"] == true) {
          // Parse and store the data in the model
          mutualFundData.value = getMutualFundOverviewModelFromJson(response.body);
          historicalNAVDetails.value = mutualFundData.value.data!.historicalNavDetails;
          chartPeriods.value = mutualFundData.value.data!.chartPeriods;
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
}
