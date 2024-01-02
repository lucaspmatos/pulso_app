class CardiacHistory {
  int? id;
  int? userId;
  int? bpm;
  int? systolicPressure;
  int? diastolicPressure;
  double? bodyHeat;
  String? createdAt;

  CardiacHistory({
    this.id,
    this.userId,
    this.bpm,
    this.systolicPressure,
    this.diastolicPressure,
    this.bodyHeat,
    this.createdAt,
  });

  CardiacHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bpm = json['bpm'];
    systolicPressure = json['systolic_pressure'];
    diastolicPressure = json['diastolic_pressure'];
    bodyHeat = double.tryParse(json['body_heat'].toString());
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['bpm'] = bpm;
    data['systolic_pressure'] = systolicPressure;
    data['diastolic_pressure'] = diastolicPressure;
    data['body_heat'] = bodyHeat;
    return data;
  }
}
