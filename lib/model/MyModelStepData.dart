import 'package:activity_tracker/logic/get_data_from_google_fit.dart';
import 'package:flutter/material.dart';

class MyModelStepData extends ChangeNotifier {
  var stepCount = '0';
  var stepProgres = 0.0;
  final getDataFromGoogleFit = GetDataFromGoogleFit();

  Future<void> getData() async {
    stepCount = await getDataFromGoogleFit.printData();
    stepProgres = int.parse(stepCount) / 10000;

    notifyListeners();
  }
}
