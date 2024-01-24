import 'package:heart_bpm/heart_bpm.dart';

class CardiacHistory {
  int? id;
  int? userId;
  int? bpm;
  List<dynamic>? bpmValues;
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
    if (json['bpm_values'] != null) {
      bpmValues = <dynamic>[];
      json['bpm_values'].forEach((v) {
        bpmValues!.add((v));
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
      data['bpm_values'] = bpmValues!
          .map((v) => {
                "time": v.time.toString(),
                "value": v.value.toString(),
              })
          .toList();
    }
    data['systolic_pressure'] = systolicPressure;
    data['diastolic_pressure'] = diastolicPressure;
    data['body_heat'] = bodyHeat;
    return data;
  }
}

extension ParseSensor on dynamic {
  static SensorValue fromJson(Map<String, dynamic> json) {
    return SensorValue(
        time: DateTime.parse(json['time']), value: num.parse(json['value'],));
  }
}
