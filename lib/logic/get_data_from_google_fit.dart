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
            "startTimeMillis": 1640358966000,
            "endTimeMillis": 1640456166000
          },
        ));

    if (response.statusCode == 200) {
      dev.log(response.body);
    } else {
      dev.log(response.statusCode.toString());
    }

    var steps = GoogleFitData.fromJson(jsonDecode(response.body));

    return steps;
  }
}

class GoogleFitData {
  int stepCountFromFit;

  GoogleFitData(
    this.stepCountFromFit,
  );

  factory GoogleFitData.fromJson(dynamic json) {
    return GoogleFitData(
      json['bucket'][0]['dataset'][0]['point'][0]['value'][0]['intVal'] as int,
    );
  }

  @override
  String toString() {
    return ' $stepCountFromFit ';
  }
}
