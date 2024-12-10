// import 'package:csv/csv.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
//
// // import 'package:http/http.dart' as http;
// import 'package:intellect_mutual_fund/my_app_exports.dart';
//
// class MutualFundController extends GetxController {
//   final globalController = Get.find<GlobalController>();
//   static RxList<ScriptInfoModel> mutualFundData = <ScriptInfoModel>[].obs;
//
//   static RxList<MergedDataModel> filteredList = <MergedDataModel>[].obs;
//
//   // Observable for loading state
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;
//
//   /// fetch data from csv file
//   Future<void> fetchFundDataFromCsv() async {
//     isLoading.value = true;
//     try {
//       final csvRawData = await rootBundle.loadString(ApiConstant.mutualFundRawData);
//
//       final csvData = await compute(parseCsvData, csvRawData);
//
//       mutualFundData.assignAll(csvData);
//     } catch (e) {
//       errorMessage.value = "Something went wrong: $e";
//       Get.snackbar(
//         "Error",
//         "Something went wrong: $e",
//         backgroundColor: AppColor.red,
//         colorText: AppColor.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   /// Isolate function to parse CSV data which has millions data
//   List<ScriptInfoModel> parseCsvData(String csvBody) {
//     final csvData = const CsvToListConverter().convert(csvBody, eol: '\n');
//     return csvData.skip(1).map((row) => ScriptInfoModel.fromCsv(row)).toList();
//   }
//
//   // Function to find and merge matching data
//   Future<void> filterAndMergeData() async {
//     try {
//       // Show loading if required
//       isLoading.value = true;
//
//       // Prepare data for isolate
//       final isolateData = {
//         "activeOrderList": OrdersController().activeOrderList.map((e) => e.toJson()).toList(),
//         "mutualFundData": mutualFundData.map((e) => e.toJson()).toList(),
//       };
//
//       // Use compute to process data in an isolate
//       final mergedData = await compute(findMatchingData, isolateData);
//
//       // Update the filteredList with the result
//       filteredList.assignAll(mergedData.map((e) => MergedDataModel.fromJson(e)).toList());
//     } catch (e) {
//       // Handle errors
//       Get.snackbar(
//         "Error",
//         "Something went wrong: $e",
//         backgroundColor: AppColor.red,
//         colorText: AppColor.white,
//       );
//     } finally {
//       // Hide loading
//       isLoading.value = false;
//     }
//   }
//
// // Isolate function to process matching data
//   List<Map<String, dynamic>> findMatchingData(Map<String, dynamic> data) {
//     final activeOrders = (data['activeOrderList'] as List).map((e) => OrderData.fromJson(e)).toList();
//     final mutualFunds = (data['mutualFundData'] as List).map((e) => ScriptInfoModel.fromJson(e)).toList();
//
//     // Merged result
//     final List<Map<String, dynamic>> mergedData = [];
//
//     // Find matches
//     for (var order in activeOrders) {
//       for (var fund in mutualFunds) {
//         if (order.schemeCode == fund.schemeCode) {
//           // Add merged data to the list
//           mergedData.add(MergedDataModel(orderData: order, scriptInfo: fund).toJson());
//         }
//       }
//     }
//
//     return mergedData;
//   }
//
//   // Function to filter and merge data
//   Future<void> filterAndMerge() async {
//     try {
//       isLoading.value = true;
//
//       // Prepare data for isolate processing
//       final isolateData = {
//         "activeOrderList": OrdersController().activeOrderList.map((e) => e.toJson()).toList(),
//         "mutualFundData": mutualFundData.map((e) => e.toJson()).toList(),
//       };
//
//       // Use compute to perform filtering and merging in an isolate
//       final mergedResults = await compute(matchAndMergeData, isolateData);
//
//       // Update the filtered list with the merged results
//       filteredList.assignAll(
//         mergedResults.map((data) => MergedDataModel.fromJson(data)).toList(),
//       );
//     } catch (e) {
//       // Handle errors gracefully
//       Get.snackbar(
//         "Error",
//         "Something went wrong: $e",
//         backgroundColor: AppColor.red,
//         colorText: AppColor.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
// // Function to be executed in an isolate
//   List<Map<String, dynamic>> matchAndMergeData(Map<String, dynamic> data) {
//     final activeOrders = (data['activeOrderList'] as List).map((e) => OrderData.fromJson(e)).toList();
//     final mutualFunds = (data['mutualFundData'] as List).map((e) => ScriptInfoModel.fromJson(e)).toList();
//
//     // Store the merged results
//     final List<Map<String, dynamic>> mergedResults = [];
//
//     // Perform matching and merging
//     for (var order in activeOrders) {
//       for (var fund in mutualFunds) {
//         if (order.schemeCode == fund.schemeCode) {
//           // Add merged data to the result
//           mergedResults.add(MergedDataModel(orderData: order, scriptInfo: fund).toJson());
//         }
//       }
//     }
//
//     return mergedResults;
//   }
// }
