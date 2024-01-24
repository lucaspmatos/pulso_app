import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:pulso_app/app/router/routes.dart';
import 'package:pulso_app/app/core/themes/themes.dart';
import 'package:pulso_app/app/broker/mqtt_handler.dart';
import 'package:pulso_app/app/core/constants/constants.dart';
import 'package:pulso_app/app/features/login/model/user.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<AccelerometerEvent> _accSub;

  void _browserLogin() {
    String userJson = jsonEncode(UserSession.instance.user);
    MqttHandler.publish(Texts.loginTopic, payload: userJson);
  }

  void _handleAccelerometerEvent() {
    _accSub = accelerometerEventStream().listen((AccelerometerEvent event) {
      if (event.z.toStringAsPrecision(2) == Numbers.gravity.toString()) {
        _browserLogin();
        dispose();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _handleAccelerometerEvent();
  }

  @override
  void dispose() {
    super.dispose();
    _accSub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
      ],
      locale: const Locale('pt', 'BR'),
      debugShowCheckedModeBanner: false,
      title: Texts.appTitle,
      theme: appTheme(),
      initialRoute: kIsWeb ? Texts.splashRoute : Texts.loginRoute,
      routes: Routes.mapRouter,
    );
  }
}
