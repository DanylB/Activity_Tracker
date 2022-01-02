import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
import 'package:shared_preferences/shared_preferences.dart';
import 'deserialization_data_from_google_fit.dart';

class GetDataFromGoogleFit {
  Future printData() async {
    /// Get Access Token from Local Storage
    var localStorage = await SharedPreferences.getInstance();
    var _accessToken = localStorage.getString('accessToken');
    dev.log('reLogin = ' + localStorage.getString('accessToken').toString());

    localStorage.remove('acessToken');

    /// Get Time from today:00:00 to now
    var year = int.parse(DateTime.now().toString().substring(0, 4));
    var mounth = int.parse(DateTime.now().toString().substring(5, 7));
    var day = int.parse(DateTime.now().toString().substring(8, 10));
    var nowTime = DateTime.now().millisecondsSinceEpoch;
    int yesterday = DateTime(year, mounth, day, 00, 00).millisecondsSinceEpoch;

    var noZone = DateTime.fromMillisecondsSinceEpoch(yesterday);

    print(noZone);

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
            "startTimeMillis": yesterday,
            "endTimeMillis": nowTime,
          },
        ));

    if (response.statusCode == 200) {
      dev.log(response.body);
    } else {
      dev.log(response.statusCode.toString());
    }

    var steps = GoogleFitData.fromJson(jsonDecode(response.body));

    return steps.toString();
  }
}
