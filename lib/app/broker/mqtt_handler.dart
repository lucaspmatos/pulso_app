import 'dart:io';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:pulso_app/app/broker/server.dart'
    if (dart.library.html) 'package:pulso_app/app/broker/browser.dart' as mqtt;

import 'package:pulso_app/app/core/constants/constants.dart';

class MqttHandler {
  static final client = mqtt.setup();

  static void publish(String topic, {String payload = ''}) async {
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
      final builder = MqttClientPayloadBuilder();
      builder.addString(payload);
      client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
    }
  }

  static void subscribe(
      List<String> topics, Function(String topic, String payload) func) async {
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
        final pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        func(c[0].topic, pt);
        print(Texts.topicLog(c[0].topic, pt));
      });
    }
  }
}
