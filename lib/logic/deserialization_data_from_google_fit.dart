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
