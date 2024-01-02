import 'package:heart_bpm/heart_bpm.dart';
import 'package:pulso_app/app/features/history/model/cardiac_history.dart';

abstract class MonitorView {
  void setButtonValue();
  void setBodyHeat(String value);
  void setSystolicPressure(String value);
  void setDiastolicPressure(String value);
}

abstract class MonitorController {
  void subscribeTopics();
  void calcBPM(List<SensorValue> bpmList);
  void stopMeasurement(CardiacHistory history);
}