import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../my_app_exports.dart';

class ExploreFundsController extends GetxController {
  RxList<ExploreFundsModel> exploreFundList = <ExploreFundsModel>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  Future<void> fetchExploreFunds() async {
    final Map<String, dynamic> requestBody = {
      "schemeAMCs": [
        18,
        1,
        2,
        59,
        16,
        58,
        5,
        6,
        8,
        9,
        11,
        20,
        12,
        60,
        13,
        14,
        17,
        19,
        21,
        54,
        22,
        23,
        25,
        26,
        27,
        28,
        10,
        33,
        56,
        62,
        7,
        29,
        31,
        32,
        34,
        57,
        35,
        36,
        37,
        38,
        39,
        55,
        40,
        41,
        42,
        61
      ],
      "schemeAssetClasses": [1],
      "schemeCategories": [24, 25, 31, 34],
      "schemeRisks": [1, 2, 3, 4, 5, 6],
      "schemeCodes": null,
      "sortColumn": "1Y Return",
      "sortOrder": 1,
      "recordsPerPage": 10,
      "pageNumber": 0,
      "schemeRating": [0, 1, 2, 3, 4, 5]
    };

    try {
      isLoading(true);
      final response = await http.post(
        Uri.parse(ApiConstant.getExploreFunds),
        headers: {
          'Content-Type': 'application/json', // Important for JSON requests
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print("reponse data >>>>>> $result");
        List<ExploreFundsModel> fundList = (result as List).map((data) => ExploreFundsModel.fromJson(data)).toList();
        exploreFundList.value = fundList;
      } else {
        errorMessage.value = 'Error fetching data';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }
}
