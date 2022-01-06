class GoogleFitData {
  var stepCountFromFit;

  GoogleFitData(
    this.stepCountFromFit,
  );

  factory GoogleFitData.fromJson(dynamic json) {
    return GoogleFitData([
      json['bucket'][0]['dataset'][0]['point'][0]['value'][0]['intVal'],
      json['bucket'][0]['dataset'][1]['point'][0]['value'][0]['fpVal'],
    ]);
  }

  // @override
  // String toString() {
  //   return ' $stepCountFromFit ';
  // }

  toList() {
    return stepCountFromFit;
  }
}
