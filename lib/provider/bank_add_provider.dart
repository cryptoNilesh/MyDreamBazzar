import 'dart:async';
import 'dart:convert';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/team_count_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:http/http.dart' as http;

class BankAddApi {
  Future<dynamic> onBankAddApi(String accountname, String accountnumber,
      String ifsc, String extra, String extra2, String user_id) async {
    try {
      final uri =
          Uri.parse(AppConstants.BASE_URL+'/api/v1/bank-add');

      dynamic postData = {
        'account_name': accountname,
        'account_number': accountnumber,
        'ifsc': ifsc,
        'extra': extra,
        'extra2': extra2,
        'date':
            '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
        'time':
            '${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}',
        'user_id': user_id
      };
      final response =
          await http.post(uri, body: json.encode(postData), headers: {
        'content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        // 'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}',
      });

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return TeamCountModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
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
