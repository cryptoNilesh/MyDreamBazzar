import 'dart:async';
import 'dart:convert';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/team_count_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:http/http.dart' as http;

class TeamCountApi {
  Future<dynamic> onTeamCountApi(String phonenumber) async {
    try {
      final uri =
          Uri.parse(AppConstants.BASE_URL+'/api/v1/team-count');

      dynamic postData = {'phone_number': phonenumber};
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {
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
