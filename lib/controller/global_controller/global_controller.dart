import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  // API Endpoints
  String baseUrl = ''; // baseUrl
  String getExploreFunds = ''; // explore Fund
  String postOrders = ''; // POST Orders
  String getActiveOrders = ''; // GET Orders

  String postSipOrders = ''; // POST Sip Orders

  String getFundOverview = ''; // post method // fund details

  String getFundOverViewCalcInfo = ''; //  post method // calculation details
  String addToWatchList = ''; //  POST method // Add To watchlist
  String getWatchList = ''; //  GET method // get watchlist data
  String deleteWatchList = ''; //  DELETE method // delete watchlist

  // User data
  int? clientCode; // Client Code
  int? mPin; // mPin
  String? userName; // Developer Name
  RxList orders = <String>[].obs; // Example for storing orders
  // var navigatorKey = null;
  GlobalKey<NavigatorState>? navigatorKey; // for maintaining navigation properies across sdk
  GlobalKey<ScaffoldMessengerState>? scaffoldKey;

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
    required String fundOverview,
    required String fundOverviewCalInfo,
    required String AddToWatchlist,
    required String GetWatchlist,
    required String DeleteWatchlist,
    dynamic navigatorkey,
    dynamic scaffoldkey,
  }) {
    // developer = dev;
    baseUrl = baseurl;
    getExploreFunds = exploreFund;
    postOrders = postOrder;
    postSipOrders = postSipOrder;
    getActiveOrders = activeOrders;
    getFundOverview = fundOverview;
    getFundOverViewCalcInfo = fundOverviewCalInfo;
    addToWatchList = AddToWatchlist;
    getWatchList = GetWatchlist;
    deleteWatchList = DeleteWatchlist;
    navigatorKey = navigatorkey;
    scaffoldKey = scaffoldkey;
  }

  void setUserData({
    required int clientcode,
    required int mpin,
    required String userName,
  }) {
    this.clientCode = clientcode;
    this.mPin = mpin;
    this.userName = userName;
  }

  // You can also create other methods to manipulate global data like orders
  void setOrders(List<String> orderList) {
    orders.assignAll(orderList);
  }

  void checkDetails() {
    print('GET SCAFFOLD KEY >>>>>> $scaffoldKey');
    print('GET NAVIGATOR KEY >>>>>> $navigatorKey');
    print('M-PIN >>>>> $mPin');
    print('USER NAME >>>>> $userName');
    print('CLIENT CODE >>>>> $clientCode');
    print('BASE URL >>>>> $baseUrl');
    print('POST SIP ORDER >>>>> $postSipOrders');
    print('POST LUMPSUM ORDER >>>>> $postOrders');
    print('GET EXPLORE FUND >>>>> $getExploreFunds');
    print('GET ACTIVE ORDERS >>>>> $getActiveOrders');
    // print('ADD TO WATCHLIST  >>>>> $addToWatchList');
    // print('GET WATCHLIST  >>>>> $getWatchList');
    // print('DELETE FROM WATCHLIST  >>>>> $deleteWatchList');
  }
}
