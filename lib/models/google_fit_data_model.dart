import 'package:activity_tracker/logic/get_data_from_google_fit.dart';
import 'package:flutter/material.dart';

enum ActivityTypes {
  steps,
  distance,
  calories,
}

class GoogleFitDataModel extends ChangeNotifier {
  int stepCount = 0;
  double stepProgress = 0.0;

  double distanceCount = 0;
  double distanceProgress = 0.0;

  int caloriesCount = 0;
  double caloriesProgress = 0.0;

  final getDataFromGoogleFit = GetDataFromGoogleFit();

  Future<void> getData() async {
    var dataFromGoogleFit = await getDataFromGoogleFit.printData();

    stepCount = dataFromGoogleFit[ActivityTypes.steps.index];
    stepProgress = stepCount / 10000;
    ////
    distanceCount = dataFromGoogleFit[ActivityTypes.distance.index] / 1000;
    distanceCount = double.parse(distanceCount.toStringAsFixed(3));
    distanceProgress = distanceCount / 20;
    ////.
    caloriesCount = dataFromGoogleFit[ActivityTypes.calories.index];
    caloriesProgress = caloriesCount / 10000;

    notifyListeners();
  }
}
