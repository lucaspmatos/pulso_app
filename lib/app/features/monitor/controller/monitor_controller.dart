import 'dart:io';

import 'package:heart_bpm/heart_bpm.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'package:pulso_app/app/core/constants/constants.dart';
import 'package:pulso_app/app/features/monitor/contract/monitor_contract.dart';

class MonitorControllerImpl implements MonitorController {
  MonitorView _view;

  MonitorControllerImpl(this._view);

  MqttServerClient client = MqttServerClient.withPort('54.147.89.192', '', 1883);

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
      client.subscribe(Texts.bodyHeatTopic, MqttQos.atLeastOnce);
      client.subscribe(Texts.systolicTopic, MqttQos.atLeastOnce);
      client.subscribe(Texts.diastolicTopic, MqttQos.atLeastOnce);

      client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c![0].payload as MqttPublishMessage;
        final pt =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        _changeSensorValues(c[0].topic, pt);

        /// The above may seem a little convoluted for users only interested in the
        /// payload, some users however may be interested in the received publish message,
        /// lets not constrain ourselves yet until the package has been in the wild
        /// for a while.
        /// The payload is a byte buffer, this will be specific to the topic
        print(
            'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
        print('');
      });
    }
  }

  @override
  stopMeasurement() {
    client.disconnect();
    _view.setButtonValue();
  }

  _sendWhatsApp(int avg) async {
    if (avg > 10) {
      var whatsappUrl =
          "https://api.callmebot.com/whatsapp.php?phone=[]&text=This+is+a+test+from+CallMeBot&apikey=[]";
      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(Uri.parse(whatsappUrl));
      } else {
        throw 'Could not launch $whatsappUrl';
      }
    }
  }

  @override
  void calcBPM(List<SensorValue> bpmList) {
    if (bpmList.isNotEmpty) {
      int sum = 0;
      bpmList.forEach((e) => sum += e.value.toInt());
      int avg = sum ~/ bpmList.length;
      _sendWhatsApp(avg);
    }
  }
}
