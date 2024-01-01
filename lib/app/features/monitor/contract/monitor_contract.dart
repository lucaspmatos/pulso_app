import 'package:heart_bpm/heart_bpm.dart';

abstract class MonitorView {
  void setButtonValue();
  void setBodyHeat(String value);
  void setSystolicPressure(String value);
  void setDiastolicPressure(String value);
}

abstract class MonitorController {
  void subscribeTopics();
  void stopMeasurement();
  void calcBPM(List<SensorValue> bpmList);
}