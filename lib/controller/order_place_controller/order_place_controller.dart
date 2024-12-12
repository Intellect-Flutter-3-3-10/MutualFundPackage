import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intellect_mutual_fund/my_app_exports.dart';

class OrderPlaceController extends GetxController {
  final globalController = Get.find<GlobalController>();
  Rx<AddSipOrderModel> placeSipOrder = AddSipOrderModel().obs;
  Rx<AddOrderModel> placeOrder = AddOrderModel().obs;
  RxBool isLoading = false.obs;
  RxBool isOrderLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxString orderError = ''.obs;

  RxString selectedDate = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  /// place SIP Order
  Future<void> addSipOrder(AddSipOrderModel order) async {
    try {
      isLoading(true);
      print(' SIP Order >>>>> ${order.toJson()}'); // Debugging serialized data

      final response = await http.post(
        Uri.parse(globalController.postSipOrders),
        headers: {
          'Content-Type': 'application/json', // Set header for JSON
        },
        body: jsonEncode(order.toJson()), // Convert object to JSON string
      );

      if (response.statusCode == 200) {
        // Deserialize response into your model
        final responseData = jsonDecode(response.body);
        final orderResponse = OrderResModel.fromJson(responseData);

        if (orderResponse.status == true) {
          Get.snackbar(
            'Success',
            orderResponse.message ?? 'Order placed successfully',
            backgroundColor: AppColor.green,
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          Get.snackbar(
            'Failed',
            orderResponse.message ?? 'Order placement failed',
            backgroundColor: AppColor.red,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        // Handle HTTP errors
        final errorMessage = jsonDecode(response.body)['message'] ?? 'Failed to place order';
        Get.snackbar(
          'Failed',
          errorMessage,
          backgroundColor: AppColor.red,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      // Handle network or parsing errors
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: AppColor.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false); // Ensure loading state is updated
    }
  }

  /// place Order
  Future<void> addOrder(AddOrderModel order) async {
    try {
      isOrderLoading(true);
      print('Normal Order >>>>> ${order.toJson()}'); // Debugging serialized data

      final response = await http.post(
        Uri.parse(globalController.postOrders),
        headers: {
          'Content-Type': 'application/json', // Set header for JSON
        },
        body: jsonEncode(order.toJson()), // Convert object to JSON string
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final orderResponse = OrderResModel.fromJson(responseData);

        if (orderResponse.status == true) {
          Get.snackbar(
            'Success',
            orderResponse.message ?? 'Order placed successfully',
            backgroundColor: AppColor.green,
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          Get.snackbar(
            'Failed',
            orderResponse.message ?? 'Order placement failed',
            backgroundColor: AppColor.red,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        // Handle HTTP errors
        final orderError = jsonDecode(response.body)['message'] ?? 'Failed to place order';
        Get.snackbar(
          'Failed',
          orderError,
          backgroundColor: AppColor.red,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: AppColor.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isOrderLoading(false); // Ensure loading state is updated
    }
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900); // Define the first selectable date
    DateTime lastDate = DateTime(2100); // Define the last selectable date

    // Show the date picker
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      // Extract day, month, and year separately
      int day = pickedDate.day;
      int month = pickedDate.month;
      int year = pickedDate.year;

      // Format and store them in your desired format
      // selectedDate.value = '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
      selectedDate.value = '${day.toString().padLeft(2, '0')}';
      // OrderPlaceController().selectedDate.value = day.toString();
      print("SELECTED DATE >>>>>${day.toString().padLeft(2, '0')}");
      update();

      // This will save as "YYYY-MM-DD"

      // Optionally, if you need separate values
      String formattedDay = day.toString().padLeft(2, '0');
      String formattedMonth = month.toString().padLeft(2, '0');
      String formattedYear = year.toString();

      // You can now use formattedDay, formattedMonth, and formattedYear individually as needed
    }
  }
}
