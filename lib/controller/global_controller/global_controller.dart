import 'package:get/get.dart';

class GlobalController extends GetxController {
  // API Endpoints
  String baseUrl = '';
  String getExploreFunds = '';
  String postOrders = '';
  String getOrders = '';
  String getActiveOrders = '';

  String postSipOrders = '';

  // User data
  int? clientCode;
  int? mPin;
  String? developer;

  RxList orders = <String>[].obs; // Example for storing orders

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkDetails();
  }

  // Setters for API endpoints and user data
  void setApiEndpoints({
    required String baseurl,
    required String exploreFund,
    required String postOrder,
    required String postSipOrder,
    required String getActiveOrder,
    required String dev,
  }) {
    baseUrl = baseurl;
    getExploreFunds = exploreFund;
    postOrders = postOrder;
    postSipOrders = postSipOrder;
    developer = dev;
    getActiveOrders = getActiveOrder;
  }

  void setUserData(int clientcode, int mpin) {
    this.clientCode = clientcode;
    this.mPin = mpin;
  }

  // You can also create other methods to manipulate global data like orders
  void setOrders(List<String> orderList) {
    orders.assignAll(orderList);
  }

  void checkDetails() {
    print('$mPin >>>>>>>');
    print('$developer >>>>>>>');
    print('$baseUrl >>>>>>>');
    print('$postSipOrders >>>>>>>');
    print('$postOrders >>>>>>>');
    print('$getExploreFunds >>>>>>>');
    print('$getOrders >>>>>>>');
  }
}
