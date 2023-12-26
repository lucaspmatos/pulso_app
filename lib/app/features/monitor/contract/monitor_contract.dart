import 'package:heart_bpm/heart_bpm.dart';

abstract class MonitorController {
  void calcBPM(List<SensorValue> bpmList);
}