import 'package:get/get.dart';

class MasterController extends GetxController {
  var isLoading = false.obs;

  onInit() {
    super.onInit();
    fetchMfData();
  }

  Future<void> fetchMfData() async {
    /// todo
  }
}
