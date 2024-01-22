import 'dart:io';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:pulso_app/app/broker/server.dart'
    if (dart.library.html) 'package:pulso_app/app/broker/browser.dart' as mqtt;

import 'package:pulso_app/app/api/history_service.dart';
import 'package:pulso_app/app/api/monitor_service.dart';
import 'package:pulso_app/app/core/constants/constants.dart';
import 'package:pulso_app/app/features/login/model/user.dart';
import 'package:pulso_app/app/features/history/model/cardiac_history.dart';
import 'package:pulso_app/app/features/monitor/contract/monitor_contract.dart';

class MonitorControllerImpl implements MonitorController {
  final MonitorView _view;
  MonitorControllerImpl(this._view);
  var client = mqtt.setup();

  List<String> topics = [
    Texts.bpmTopic,
    Texts.bodyHeatTopic,
    Texts.systolicTopic,
    Texts.diastolicTopic
  ];

  int bpmAvg = 0;

  _sendWhatsApp(CardiacHistory report) async {
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
      await HistoryService.postHistory(newHistory);
      Fluttertoast.showToast(msg: Texts.saveHistorySuccessMsg);
    } catch (e) {
      Fluttertoast.showToast(msg: Texts.saveHistoryErrorMsg);
    }
  }

  @override
  void subscribeTopics() async {
    client.setProtocolV311();
    client.websocketProtocols = MqttClientConstants.protocolsSingleDefault;

    try {
      await client.connect();
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      print(Texts.clientException(e.toString()));
      client.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      print(Texts.socketException(e.toString()));
      client.disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      for (var topic in topics) {
        client.subscribe(topic, MqttQos.atLeastOnce);
      }

      client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c![0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        _changeSensorValues(c[0].topic, pt);
        print(Texts.topicLog(c[0].topic, pt));
      });
    }
  }

  @override
  void stopMeasurement() {
    client.disconnect();
    _view.setButtonValue();
  }

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
        systolicPressure: history.last.systolicPressure,
        diastolicPressure: history.last.diastolicPressure,
        bodyHeat: history.last.bodyHeat,
      );
      _saveHistory(report);
      _sendWhatsApp(report);
    }
  }
}
