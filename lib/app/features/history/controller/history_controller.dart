import 'package:fluttertoast/fluttertoast.dart';

import 'package:pulso_app/app/api/monitor_service.dart';
import 'package:pulso_app/app/api/history_service.dart';
import 'package:pulso_app/app/broker/mqtt_handler.dart';

import 'package:pulso_app/app/core/constants/constants.dart';
import 'package:pulso_app/app/features/login/model/user.dart';
import 'package:pulso_app/app/features/history/model/cardiac_history.dart';
import 'package:pulso_app/app/features/history/contract/history_contract.dart';

class HistoryControllerImpl implements HistoryController {
  final HistoryView _view;
  List<CardiacHistory> fetchedHistory = [];
  HistoryControllerImpl(this._view);

  void _changeSensorValue(String topic, String payload) {
    if (topic == Texts.refreshTopic) _view.reloadPage();
  }

  @override
  void screenOpened() {
    UserSession.instance.currentRoute = Texts.historyRoute;
    MqttHandler.subscribe([Texts.refreshTopic], _changeSensorValue);
  }

  @override
  void deleteHistory(int id) async {
    try {
      await HistoryService.deleteHistory(id)
          .then((_) => MqttHandler.publish(Texts.refreshTopic));
    } catch (e) {
      Fluttertoast.showToast(msg: Texts.deleteHistoryErrorMsg);
    }
  }

  @override
  void sendWhatsApp(CardiacHistory report) async {
    String msg = Texts.cardiacReport;
    msg += "\n${Texts.bpmTitle} ${report.bpm}\n";
    msg += "\n${Texts.pressureTitle} ${report.systolicPressure}";
    msg += "x ${report.diastolicPressure} ${Texts.pressureMeasure}\n";
    msg += "\n${Texts.tempTitle} ${report.bodyHeat} ${Texts.celsius}\n";

    await MonitorService.sendMessage(msg);
    Fluttertoast.showToast(msg: Texts.whatsAppMsgSuccess);
  }

  @override
  Future<List<CardiacHistory>?> loadHistory() async {
    try {
      fetchedHistory = await HistoryService.getHistory();
      return fetchedHistory;
    } catch (e) {
      Fluttertoast.showToast(msg: Texts.loadHistoryMsg);
      return null;
    }
  }
}
