import 'package:get/get.dart';

class GlobalController extends GetxController {
  // API Endpoints
  String baseUrl = ''; // baseUrl
  String getExploreFunds = ''; // explore Fund
  String postOrders = ''; // POST Orders
  String getActiveOrders = ''; // GET Orders

  String postSipOrders = ''; // POST Sip Orders

  // User data
  int? clientCode; // Client Code
  int? mPin; // mPin
  String? developer; // Developer Name

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
    required String activeOrders,
    required String dev,
  }) {
    baseUrl = baseurl;
    getExploreFunds = exploreFund;
    postOrders = postOrder;
    postSipOrders = postSipOrder;
    developer = dev;
    getActiveOrders = activeOrders;
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
    print('M-PIN $mPin >>>>>>>');
    print('DEVELOPER NAME $developer >>>>>>>');
    print('BASE URL $baseUrl >>>>>>>');
    print('POST SIP ORDER $postSipOrders >>>>>>>');
    print('POST LUMPSUM ORDER $postOrders >>>>>>>');
    print('GET EXPLORE FUND $getExploreFunds >>>>>>>');
    print('GET ACTIVE ORDERS $getActiveOrders >>>>>>>');
  }
}
