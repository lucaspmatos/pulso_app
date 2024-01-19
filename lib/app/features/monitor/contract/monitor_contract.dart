import 'package:pulso_app/app/features/history/model/cardiac_history.dart';

abstract class MonitorView {
  void setButtonValue();
  void setBpm(String value);
  void setBodyHeat(String value);
  void setSystolicPressure(String value);
  void setDiastolicPressure(String value);
}

abstract class MonitorController {
  void stopMeasurement();
  void subscribeTopics();
  void calcHistory(List<CardiacHistory> history);
}