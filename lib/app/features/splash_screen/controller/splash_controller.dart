import 'dart:convert';

import 'package:pulso_app/app/broker/mqtt_handler.dart';
import 'package:pulso_app/app/core/constants/constants.dart';

import 'package:pulso_app/app/features/login/model/user.dart';
import 'package:pulso_app/app/features/splash_screen/contract/splash_contract.dart';

class SplashControllerImpl implements SplashController {
  final SplashView _view;
  SplashControllerImpl(this._view);
  List<String> topics = [Texts.loginTopic];

  _changeSensorValue(String topic, String payload) {
    if (topic == Texts.loginTopic) {
      UserSession.instance.user = User.fromJson(jsonDecode(payload));
      _view.goToMonitor();
    }
  }

  @override
  void subscribeTopic() => MqttHandler.subscribe(topics, _changeSensorValue);
}
