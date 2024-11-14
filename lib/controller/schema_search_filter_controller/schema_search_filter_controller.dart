import 'dart:convert';

import 'package:get/get.dart';
import 'package:intellect_mutual_fund/api_constants/api_constants.dart';
import 'package:intellect_mutual_fund/model/scheme_search_filter_model/scheme_search_filter_model.dart';
import 'package:http/http.dart' as http;

class SchemaSearchFilterController extends GetxController {
  var isLoading = false.obs;
  SchemaSearchFilterModel? schemaSearchFilterModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchSchemaSearchFilter();
  }

  Future<void> fetchSchemaSearchFilter() async {
    try {
      isLoading(true);
      http.Response response = await http.get(Uri.tryParse(ApiConstant.getSchemaSearchFilter)!);
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        schemaSearchFilterModel = SchemaSearchFilterModel.fromJson(result);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }
}
