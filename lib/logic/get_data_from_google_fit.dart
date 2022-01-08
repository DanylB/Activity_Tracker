import 'dart:convert';
import 'dart:core';
import 'package:activity_tracker/logic/google_login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
import 'package:shared_preferences/shared_preferences.dart';
import 'deserialization_data_from_google_fit.dart';

enum ActivityTypes {
  steps,
  distance,
  calories,
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
                "dataTypeName": "com.google.step_count.delta",
                "dataSourceId":
                    "derived:com.google.step_count.delta:com.google.android.gms:estimated_steps"
              },
              //distance (meters)
              {
                "dataTypeName": "com.google.distance.delta",
                "dataSourceId":
                    "derived:com.google.distance.delta:com.google.android.gms:merge_distance_delta"
              },
              //calories
              {
                "dataTypeName": "com.google.calories.expended",
                "dataSourceId":
                    "derived:com.google.calories.expended:com.google.android.gms:merge_calories_expended"
              },
              //
              //{
              // "dataTypeName": "com.google.sleep.segment",
              // "dataSourceId":
              //     "derived:com.google.sleep.segment:com.google.android.gms:merged"
              // },
              // {
              //   "dataTypeName": "com.google.active_minutes",
              //   "dataSourceId":
              //       "derived:com.google.active_minutes:com.google.android.gms:merge_active_minutes"
              // },
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

  var arrayDataFromGoogleFit = [0, 0];

  Future printData() async {
    var _accessToken = await _getAccessToken();
    var yesterdayDate = _getTodayDate()[0];
    var nowTime = _getTodayDate()[1];

    var response = await _sendRequest(_accessToken, yesterdayDate, nowTime);

    response.statusCode == 200
        ? {dev.log(response.body)}
        : {dev.log(response.statusCode.toString())};
    var arrayDataFromGoogleFit = [];

    // dev.log(jsonDecode(response.body)['bucket'][0]['dataset'][2]['point'][0]
    //         ['value'][0]['fpVal']
    //     .toString()
    //     .split('.')
    //     .toList()[0]);

    // if (jsonDecode(response.body)['bucket'][0]['dataset'][1]['point']
    //         .toString() ==
    //     '[]') dev.log('QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ');

    try {
      arrayDataFromGoogleFit =
          GoogleFitData.fromJson(jsonDecode(response.body)).toList();
    } catch (e) {
      final providerReLogin = GoogleSignInProvider();
      providerReLogin.reLogin();
      await _sendRequest(_accessToken, yesterdayDate, nowTime);

      // dev.log('CATCH Resposne = $_accessToken');
    }
    dev.log('${arrayDataFromGoogleFit.toList()[ActivityTypes.steps.index]}');

    return [
      arrayDataFromGoogleFit.toList()[ActivityTypes.steps.index],
      arrayDataFromGoogleFit.toList()[ActivityTypes.distance.index],
      arrayDataFromGoogleFit.toList()[ActivityTypes.calories.index],
    ];
  }
}
