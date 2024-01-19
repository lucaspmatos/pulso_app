import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';

import 'package:pulso_app/app/core/constants/constants.dart';

MqttClient setup() => MqttBrowserClient.withPort(
      Texts.browserServer,
      Texts.clientIdentifier,
      Numbers.browserPort,
    );
