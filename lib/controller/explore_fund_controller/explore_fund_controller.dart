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
        ApiConstant.getExploreFunds,
      ));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        ExploreFundsModel fundModel = ExploreFundsModel.fromJson(jsonData);
        if (fundModel.status == true) {
          exploreFundList.value = fundModel.data ?? [];
        } else {
          // Get.snackbar('Error', fundModel.message ?? 'Something went wrong');
          errorMessage.value = fundModel.message!;
        }
      } else {
        // Get.snackbar('Error', 'Failed to fetch data');
        errorMessage.value = 'Error Failed to fetch data';
      }
    } catch (error) {
      errorMessage.value = error.toString();
      // Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
