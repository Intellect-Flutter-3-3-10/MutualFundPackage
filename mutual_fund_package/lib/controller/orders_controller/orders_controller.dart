import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../my_app_exports.dart';

class OrdersController extends GetxController {
  RxList<OrderData> ordersList = <OrderData>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  void onInit() {
    super.onInit();
    // fetchExploreFunds();
  }

  /// fetch active orders
  Future<void> getActiveOrders(String clientCode) async {
    try {
      isLoading(true);

      // Append clientCode as a query parameter to the URL
      final uri = Uri.parse(ApiConstant.getOrders).replace(queryParameters: {
        'clientCode': clientCode,
      });

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json', // Set header for JSON
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final orders = GetOrdersModel.fromJson(jsonData);

        if (orders.status == true) {
          ordersList.value = orders.data ?? [];
        } else {
          errorMessage.value = orders.message ?? 'Something went wrong';
        }
      } else {
        errorMessage.value = 'Error: Failed to fetch data';
      }
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      isLoading(false);
    }
  }
}