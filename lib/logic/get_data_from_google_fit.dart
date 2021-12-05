import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

import 'package:shared_preferences/shared_preferences.dart';

class GetDataFromGoogleFit {
  Future printData() async {
    /// Get Access Token from Local Storage
    var localStorage = await SharedPreferences.getInstance();
    var _accessToken = localStorage.getString('accessToken');
    localStorage.remove('acessToken');

    var response = await http.post(
        Uri.parse(
            'https://www.googleapis.com/fitness/v1/users/me/dataset:aggregate'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_accessToken',
        },
        body: jsonEncode(
          {
            "aggregateBy": [
              {
                "dataSourceId":
                    "derived:com.google.step_count.delta:com.google.android.gms:estimated_steps"
              }
            ],
            "bucketByTime": {"durationMillis": 86400000},
            "startTimeMillis": 1637442000000,
            "endTimeMillis": 1637505295000
          },
        ));
    // var response2 = await http.get(Uri.parse(
    //     "https://www.googleapis.com/oauth2/v3/tokeninfo?access_token=$_accessToken"));

    if (response.statusCode == 200) {
      dev.log(response.body);
    } else {
      dev.log(response.statusCode.toString());
    }

    dev.log('kllkjlkjlkjlkjlkj');
  }
}
