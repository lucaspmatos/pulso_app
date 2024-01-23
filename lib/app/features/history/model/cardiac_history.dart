class CardiacHistory {
  int? id;
  int? userId;
  int? bpm;
  List<BpmValue>? bpmValues;
  int? systolicPressure;
  int? diastolicPressure;
  double? bodyHeat;
  String? createdAt;

  CardiacHistory({
    this.id,
    this.userId,
    this.bpm,
    this.bpmValues,
    this.systolicPressure,
    this.diastolicPressure,
    this.bodyHeat,
    this.createdAt,
  });

  CardiacHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bpm = json['bpm'];
    if (json['bpmValues'] != null) {
      bpmValues = <BpmValue>[];
      json['bpmValues'].forEach((v) {
        bpmValues!.add(BpmValue.fromJson(v));
      });
    }
    systolicPressure = json['systolic_pressure'];
    diastolicPressure = json['diastolic_pressure'];
    bodyHeat = double.tryParse(json['body_heat'].toString());
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['bpm'] = bpm;
    if (bpmValues != null) {
      data['bpmValues'] = bpmValues!.map((v) => v.toJson()).toList();
    }
    data['systolic_pressure'] = systolicPressure;
    data['diastolic_pressure'] = diastolicPressure;
    data['body_heat'] = bodyHeat;
    return data;
  }
}

class BpmValue {
  DateTime? time;
  num? value;

  BpmValue({this.time, this.value});

  BpmValue.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['value'] = value;
    return data;
  }
}
