import 'dart:async';
import 'dart:convert';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/balance_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:http/http.dart' as http;

class BalanceApi {
  Future<dynamic> onBalanceApi(String userid) async {
    try {
      final uri = Uri.parse(AppConstants.BASE_URL+'/api/v1/balance');

      dynamic postData = {'user_id': userid};
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {
            'content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest'
          });

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return BalanceModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return BalanceModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}
