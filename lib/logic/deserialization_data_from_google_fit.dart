class GoogleFitData {
  var stepCountFromFit = [];

  GoogleFitData(
    this.stepCountFromFit,
  );

  factory GoogleFitData.fromJson(dynamic json) {
    return GoogleFitData([
      /// steps String
      json['bucket'][0]['dataset'][0]['point'].toString() == '[]'
          ? 0.toString()
          : '${json['bucket'][0]['dataset'][0]['point'][0]['value'][0]['intVal']}',

      ///distance String
      json['bucket'][0]['dataset'][1]['point'].toString() == '[]'
          ? '0'
          : '${json['bucket'][0]['dataset'][1]['point'][0]['value'][0]['fpVal']}'
              .split('.')
              .toList()[0],

      ///calories int
      json['bucket'][0]['dataset'][2]['point'].toString() == '[]'
          ? '0'
          : '${json['bucket'][0]['dataset'][2]['point'][0]['value'][0]['fpVal']}'
              .split('.')
              .toList()[0],

      ///active minutes int
      json['bucket'][0]['dataset'][3]['point'].toString() == '[]'
          ? '0'
          : '${json['bucket'][0]['dataset'][3]['point'][0]['value'][0]['intVal']}'
              .split('.')
              .toList()[0],

      ///speed
      // json['bucket'][0]['dataset'][4]['point'].toString() == '[]'
      //     ? '0'
      //     : '${json['bucket'][0]['dataset'][4]['point'][0]['value'][0]['fpVal']}'
    ]);
  }

  List<int> toList() {
    return [
      int.parse(stepCountFromFit[ActivityTypes.steps.index]),
      int.parse(stepCountFromFit[ActivityTypes.distance.index]),
      int.parse(stepCountFromFit[ActivityTypes.calories.index]),
      int.parse(stepCountFromFit[ActivityTypes.activMinutes.index]),
    ];
  }
}

enum ActivityTypes {
  steps,
  distance,
  calories,
  activMinutes,
}
