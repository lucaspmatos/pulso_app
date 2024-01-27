import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:pulso_app/app/broker/mqtt_handler.dart';

import 'package:pulso_app/app/api/history_service.dart';
import 'package:pulso_app/app/api/monitor_service.dart';

import 'package:pulso_app/app/core/constants/constants.dart';

import 'package:pulso_app/app/features/login/model/user.dart';
import 'package:pulso_app/app/features/history/model/cardiac_history.dart';
import 'package:pulso_app/app/features/monitor/contract/monitor_contract.dart';

class MonitorControllerImpl implements MonitorController {
  final MonitorView _view;
  MonitorControllerImpl(this._view);

  List<String> topics = [
    Texts.bpmTopic,
    Texts.bodyHeatTopic,
    Texts.systolicTopic,
    Texts.diastolicTopic
  ];

  int bpmAvg = 0;

  void _sendWhatsApp(CardiacHistory report) async {
    bool sendMessage = (report.bpm! < 50) ||
        (report.bpm! > 100) ||
        (report.systolicPressure! >= 140 && report.diastolicPressure! >= 90) ||
        (report.systolicPressure! <= 90 && report.diastolicPressure! <= 60) ||
        (report.bodyHeat! >= 39.5) ||
        (report.bodyHeat! >= 37.6) ||
        (report.bodyHeat! <= 35);

    if (sendMessage) {
      String msg = Texts.cardiacReport;

      if (report.bpm! < 50) {
        msg += "\n${Texts.bpmTitle} ${report.bpm} (BRADICARDIA)\n";
      } else if (report.bpm! > 100) {
        msg += "\n${Texts.bpmTitle} ${report.bpm} (TAQUICARDIA)\n";
      }

      if (report.systolicPressure! >= 140 && report.diastolicPressure! >= 90) {
        msg +=
            "\n${Texts.pressureTitle} ${report.systolicPressure} x ${report.diastolicPressure} ${Texts.pressureMeasure} (PRESSÃO ALTA)\n";
      } else if (report.systolicPressure! <= 90 &&
          report.diastolicPressure! <= 60) {
        msg +=
            "\n${Texts.pressureTitle}  ${report.systolicPressure} x ${report.diastolicPressure} ${Texts.pressureMeasure} (PRESSÃO BAIXA)\n";
      }

      if (report.bodyHeat! >= 39.5) {
        msg +=
            "\n${Texts.tempTitle} ${report.bodyHeat} ${Texts.celsius} (FEBRE ALTA)\n";
      } else if (report.bodyHeat! >= 37.6) {
        msg +=
            "\n${Texts.tempTitle}  ${report.bodyHeat} ${Texts.celsius} (FEBRE)\n";
      } else if (report.bodyHeat! <= 35) {
        msg +=
            "\n${Texts.tempTitle}  ${report.bodyHeat} ${Texts.celsius} (HIPOTERMIA)\n";
      }

      await MonitorService.sendMessage(msg);
      Fluttertoast.showToast(msg: Texts.whatsAppMsgSuccess);
    } else {
      return;
    }
  }

  _changeSensorValues(String topic, String payload) {
    switch (topic) {
      case Texts.bpmTopic:
        if (kIsWeb) return _view.setBpm(payload);
      case Texts.bodyHeatTopic:
        return _view.setBodyHeat(payload);
      case Texts.systolicTopic:
        return _view.setSystolicPressure(payload);
      case Texts.diastolicTopic:
        return _view.setDiastolicPressure(payload);
      default:
        return;
    }
  }

  void _saveHistory(CardiacHistory newHistory) async {
    try {
      await HistoryService.postHistory(newHistory)
          .then((_) => MqttHandler.publish(Texts.refreshTopic));
      Fluttertoast.showToast(msg: Texts.saveHistorySuccessMsg);
    } catch (e) {
      Fluttertoast.showToast(msg: Texts.saveHistoryErrorMsg);
    }
  }

@override
  void screenOpened() => UserSession.instance.currentRoute = Texts.monitorRoute;

  @override
  void stopMeasurement() {
    MqttHandler.client.disconnect();
    _view.setButtonValue();
  }

  @override
  void subscribeTopics() => MqttHandler.subscribe(topics, _changeSensorValues);

  @override
  void calcHistory(List<CardiacHistory> history) {
    if (history.isNotEmpty) {
      int sum = 0;
      for (var e in history) {
        sum += e.bpm!.toInt();
      }
      bpmAvg = sum ~/ history.length;

      CardiacHistory report = CardiacHistory(
        userId: UserSession.instance.user?.id,
        bpm: bpmAvg,
        bpmValues: _view.bpmValues,
        systolicPressure: history.last.systolicPressure,
        diastolicPressure: history.last.diastolicPressure,
        bodyHeat: history.last.bodyHeat,
      );

      _saveHistory(report);
      _sendWhatsApp(report);
      _view.bpmValues.clear();
    }
  }
}
