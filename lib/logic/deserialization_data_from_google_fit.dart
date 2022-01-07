class GoogleFitData {
  var stepCountFromFit = [];

  GoogleFitData(
    this.stepCountFromFit,
  );

  factory GoogleFitData.fromJson(dynamic json) {
    return GoogleFitData([
      /// steps
      json['bucket'][0]['dataset'][0]['point'].toString() == '[]'
          ? 0.toString()
          : '${json['bucket'][0]['dataset'][0]['point'][0]['value'][0]['intVal']}',

      ///distance
      json['bucket'][0]['dataset'][1]['point'].toString() == '[]'
          ? '0'
          : '${json['bucket'][0]['dataset'][1]['point'][0]['value'][0]['fpVal']}',
    ]);
  }

  @override
  List<int> toList() {
    return [
      int.parse(stepCountFromFit[ActivityTypes.steps.index]),
      int.parse(stepCountFromFit[ActivityTypes.distance.index]),
    ];
  }
}

enum ActivityTypes {
  steps,
  distance,
}
