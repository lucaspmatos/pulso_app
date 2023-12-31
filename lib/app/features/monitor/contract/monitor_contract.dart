import 'package:heart_bpm/heart_bpm.dart';

abstract class MonitorView {
  setBodyHeat(String value);
  setSystolicPressure(String value);
  setDiastolicPressure(String value);
}

abstract class MonitorController {
  void subscribeTopics();
  void calcBPM(List<SensorValue> bpmList);
}