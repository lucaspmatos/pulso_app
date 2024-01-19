import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'package:pulso_app/app/core/constants/constants.dart';

MqttClient setup() => MqttServerClient.withPort(
      Texts.server,
      Texts.clientIdentifier,
      Numbers.serverPort,
    );
