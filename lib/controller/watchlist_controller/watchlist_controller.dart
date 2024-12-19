import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intellect_mutual_fund/model/watchlist_models/get_watchlist_data_model.dart';
import '../../my_app_exports.dart';

class WatchListController extends GetxController {
  static RxBool isAdding = false.obs;
  static RxBool isLoading = false.obs;

  RxString errorAddWatchlist = ''.obs;
  RxString errorGetWatchlist = ''.obs;
  RxString errorDeleteWatchlist = ''.obs;

  // RxList<WatchListData> filteredWatchListData = <WatchListData>[].obs;
  Rx<GetWatchListDataModel> watchList = GetWatchListDataModel().obs;
  RxList<FundData> filteredFundList = <FundData>[].obs;
  final globalController = Get.find<GlobalController>();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> addToWatchlist(
    BuildContext context,
    AddToWatchLisModel? model,
  ) async {
    try {
      isAdding(true);
      final String requestBody = jsonEncode(model?.toJson());
      // final String url = 'https://trade.aionioncapital.com/test/MfWatchList/api/v1/MfWatchList';
      var uri = DataConstants.globalController.addToWatchList;
      final response = await http.post(
        Uri.parse(globalController.addToWatchList),
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      // Decode response
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        bool status = responseData['status'] ?? false;
        String message = responseData['message'] ?? 'Something went wrong';

        if (status) {
          filterFundsFromWatchlist();
          SnackbarHelper.showSnackbar(
            context: context,
            message: "Added To Watchlist",
          );
        } else {
          SnackbarHelper.showSnackbar(
            context: context,
            message: "Failed To Add Watchlist",
          );
        }
      } else {
        SnackbarHelper.showSnackbar(
          context: context,
          message: "Error -  Something went wrong. Please try again.",
        );
      }
    } catch (e) {
      SnackbarHelper.showSnackbar(
        context: context,
        message: "Error -  Something went wrong. Please try again.",
      );
    } finally {
      isAdding(false);
    }
  }

  Future<void> fetchWatchList({
    required String userId,
  }) async {
    try {
      isLoading(true);
      final String baseUrlLink = 'https://trade.aionioncapital.com/test/MfWatchList/api/v1/MfWatchList';
      var uri = DataConstants.globalController.getWatchList;
      final Uri url = Uri.parse('${globalController.getWatchList}/$userId');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        watchList.value = GetWatchListDataModel.fromJson(jsonData);
        filterFundsFromWatchlist();
        if (watchList.value.status != true) {
          errorGetWatchlist.value = watchList.value.message ?? 'No data found';
        }
      } else {
        errorGetWatchlist.value = 'Error: ${response.statusCode} - Failed to fetch data';
      }
    } catch (e) {
      errorGetWatchlist.value = 'Exception: ${e.toString()}';
    } finally {
      isLoading(false); // Stop loading
    }
  }

  Future<void> deleteWatchListRecord({
    required BuildContext context,
    required int id,
  }) async {
    try {
      final Uri url = Uri.parse('${globalController.deleteWatchList}/$id');

      final response = await http.delete(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['status'] == true) {
          filterFundsFromWatchlist();
          SnackbarHelper.showSnackbar(
            context: context,
            message: "Removed From WatchList",
          );
          print(jsonData['data']);
        } else {
          SnackbarHelper.showSnackbar(
            context: context,
            message: "Failed To Remove ",
          );
          print('Failed to delete: ${jsonData['message']}');
          errorDeleteWatchlist.value = 'Failed to delete: ${jsonData['message']}';
        }
      } else {
        SnackbarHelper.showSnackbar(
          context: context,
          message: "${response.statusCode} - Failed to delete record",
        );

        print('Error: ${response.statusCode} - Failed to delete record');
        errorDeleteWatchlist.value = 'Error: ${response.statusCode} - Failed to delete record';
      }
    } catch (e) {
      print('Exception: ${e.toString()}');
    }
  }

  void filterFundsFromWatchlist() {
    print("FILTER FUNCTION TRIGGERED!");
    filteredFundList.clear(); // Clear the previous data

    if (DataConstants.exploreFundsController.exploreFundList.isNotEmpty && watchList.value.data != null) {
      for (var watchItem in watchList.value.data!) {
        if (watchItem.schemeCodes != null && watchItem.schemeCodes!.isNotEmpty) {
          for (var schemeCode in watchItem.schemeCodes!) {
            for (var fund in DataConstants.exploreFundsController.exploreFundList) {
              if (fund.schemeCode.toString() == schemeCode) {
                /// Add the watchItem.id to the fund object
                FundData updatedFund = fund.copyWith(id: watchItem.id);

                /// Validation: Avoid duplicates based on schemeCode
                if (!filteredFundList.any((existingFund) => existingFund.schemeCode == updatedFund.schemeCode)) {
                  filteredFundList.add(updatedFund);
                }
              }
            }
          }
        }
      }

      /// Debugging: Check the filtered values
      print('Filtered funds with IDs: ${filteredFundList.map((fund) => 'SchemeName: ${fund.schemeName}, WatchlistId: ${fund.id}').toList()}');
    } else {
      print("Explore fund list or watch list is empty!");
    }
  }

  void addToSave({required int index, required AddToWatchLisModel? model, required BuildContext context}) {
    DataConstants.watchListController.filteredFundList[index].isInWatchList = true;
    DataConstants.watchListController.addToWatchlist(
      context,
      model,
    );
  }

  void removeFromSave({required BuildContext context, required int id}) {
    DataConstants.watchListController.deleteWatchListRecord(context: context, id: id);
  }
}
