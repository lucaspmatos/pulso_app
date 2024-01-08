import 'dart:io';

import 'package:heart_bpm/heart_bpm.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';

import 'package:pulso_app/app/api/history_service.dart';
import 'package:pulso_app/app/core/constants/constants.dart';
import 'package:pulso_app/app/features/history/model/cardiac_history.dart';
import 'package:pulso_app/app/features/monitor/contract/monitor_contract.dart';

class MonitorControllerImpl implements MonitorController {
  final MonitorView _view;
  MonitorControllerImpl(this._view);
  var client = kIsWeb ? MqttBrowserClient('', '') : MqttServerClient('', '');

  List<String> topics = [
    Texts.bodyHeatTopic,
    Texts.systolicTopic,
    Texts.diastolicTopic
  ];

  int bpmAvg = 0;

  String _setWhatsAppUrl(String text) {
    return "https://api.callmebot.com/whatsapp.php?phone=[]&text=$text&apikey=[]";
  }

  _sendWhatsApp(int avg) async {
    if (avg > 140) {
      var url = _setWhatsAppUrl("");
      await canLaunchUrl(Uri.parse(url))
          ? await launchUrl(Uri.parse(url))
          : throw 'Could not launch $url';
    }
  }

  _changeSensorValues(String topic, String payload) {
    switch (topic) {
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

  _saveHistory(CardiacHistory newHistory) async {
    try {
      await HistoryService.postHistory(newHistory);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Erro ao salvar histórico!');
    }
  }

  @override
  void subscribeTopics() async {
    client.setProtocolV311();

    try {
      await client.connect();
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      print('EXAMPLE::socket exception - $e');
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

        print('EXAMPLE:: topic is <${c[0].topic}>, payload is <-- $pt -->');
        print('');
      });
    }
  }

  @override
  stopMeasurement(CardiacHistory history) {
    client.disconnect();
    _saveHistory(history);
    _view.setButtonValue();
  }

  @override
  void calcBPM(List<SensorValue> bpmList) {
    int sum = 0;
    if (bpmList.isNotEmpty) bpmList.forEach((e) => sum += e.value.toInt());
    bpmAvg = sum ~/ bpmList.length;
    _sendWhatsApp(bpmAvg);
  }
}
