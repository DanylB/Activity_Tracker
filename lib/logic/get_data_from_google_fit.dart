import 'dart:convert';
import 'dart:core';
import 'package:activity_tracker/logic/google_login.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
import 'package:shared_preferences/shared_preferences.dart';
import 'deserialization_data_from_google_fit.dart';

enum ActivityTypes {
  steps,
  distance,
}

class GetDataFromGoogleFit {
  /// Get Data about Steps for today from Google Fit
  _sendRequest(_accessToken, yesterday, nowTime) async {
    var response = http.post(
        Uri.parse(
            'https://www.googleapis.com/fitness/v1/users/me/dataset:aggregate'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_accessToken',
        },
        body: jsonEncode(
          {
            "aggregateBy": [
              //steps
              {
                "dataSourceId":
                    "derived:com.google.step_count.delta:com.google.android.gms:estimated_steps"
              },
              //distance (meters)
              {
                "dataTypeName": "com.google.distance.delta",
                "dataSourceId":
                    "derived:com.google.distance.delta:com.google.android.gms:merge_distance_delta"
              },
            ],
            "bucketByTime": {"durationMillis": 86400000},
            "startTimeMillis": yesterday,
            "endTimeMillis": nowTime,
          },
        ));
    return response;
  }

  /// Get Access Token from Local Storage
  _getAccessToken() async {
    final localStorage = await SharedPreferences.getInstance();
    final _accessToken = localStorage.getString('accessToken');
    dev.log('_getAccessToken = ' +
        localStorage.getString('accessToken').toString());

    localStorage.remove('acessToken');
    return _accessToken;
  }

  /// Get Time from today:00:00 to now
  _getTodayDate() {
    final year = int.parse(DateTime.now().toString().substring(0, 4));
    final mounth = int.parse(DateTime.now().toString().substring(5, 7));
    final day = int.parse(DateTime.now().toString().substring(8, 10));
    final nowTime = DateTime.now().millisecondsSinceEpoch;
    int yesterday = DateTime(year, mounth, day, 00, 00).millisecondsSinceEpoch;

    return [yesterday, nowTime];
  }

  Future printData() async {
    var _accessToken = await _getAccessToken();
    var yesterdayDate = _getTodayDate()[0];
    var nowTime = _getTodayDate()[1];

    var response = await _sendRequest(_accessToken, yesterdayDate, nowTime);

    response.statusCode == 200
        ? {dev.log(response.body)}
        : {dev.log(response.statusCode.toString())};

    var arrayDataFromGoogleFit;
    try {
      arrayDataFromGoogleFit =
          GoogleFitData.fromJson(jsonDecode(response.body)).toList();
    } catch (e) {
      final providerReLogin = GoogleSignInProvider();
      providerReLogin.reLogin();
      await _sendRequest(_accessToken, yesterdayDate, nowTime);

      dev.log('CATCH Resposne = $_accessToken');
    }
    // dev.log('${arrayDataFromGoogleFit.toList()[ActivityTypes.distance.index]}');

    return [
      arrayDataFromGoogleFit.toList()[ActivityTypes.steps.index],
      arrayDataFromGoogleFit.toList()[ActivityTypes.distance.index],
    ];
  }
}
