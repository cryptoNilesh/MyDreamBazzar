import 'dart:async';
import 'dart:convert';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/team_count_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:http/http.dart' as http;

class WithdralAddApi {
  Future<dynamic> onWithdralAddApi(String amount, String user) async {
    try {
      final uri = Uri.parse(AppConstants.BASE_URL+'/api/v1/withdraw-add');
      dynamic postData = {
        'amount': amount,
        'status': '1',
        'date': '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
        'time': '${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}',
        'user_id': user
      };
      final response = await http.post(uri, body: json.encode(postData), headers: {'content-Type': 'application/json', 'X-Requested-With': 'XMLHttpRequest',});
      print("hiiii"+uri.toString()+postData.toString()+"hiii");
      print("hiiii"+response.body.toString()+"hiii");
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        print(responseJson.toString()+"???????????????????????");
        return TeamCountModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        print(responseJson.toString()+"???????????????????????");
        return TeamCountModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}
