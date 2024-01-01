import 'dart:io';

import 'package:heart_bpm/heart_bpm.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'package:pulso_app/app/core/constants/constants.dart';
import 'package:pulso_app/app/features/monitor/contract/monitor_contract.dart';

class MonitorControllerImpl implements MonitorController {
  final MonitorView _view;
  MonitorControllerImpl(this._view);

  MqttServerClient client =
      MqttServerClient.withPort('54.147.89.192', '', 1883);

  List<String> topics = [
    Texts.bodyHeatTopic,
    Texts.systolicTopic,
    Texts.diastolicTopic
  ];

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
  stopMeasurement() {
    client.disconnect();
    _view.setButtonValue();
  }

  @override
  void calcBPM(List<SensorValue> bpmList) {
    int sum = 0;
    if (bpmList.isNotEmpty) bpmList.forEach((e) => sum += e.value.toInt());
    int avg = sum ~/ bpmList.length;
    _sendWhatsApp(avg);
  }
}
