import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intellect_mutual_fund/my_app_exports.dart';

class OrderPlaceController extends GetxController {
  Rx<AddSipOrderModel> placeSipOrder = AddSipOrderModel().obs;
  Rx<AddOrderModel> placeOrder = AddOrderModel().obs;
  RxBool isLoading = false.obs;
  RxBool isOrderLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxString orderError = ''.obs;

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
        Uri.parse(ApiConstant.postSipOrders),
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
        Uri.parse(ApiConstant.postOrders),
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
}
