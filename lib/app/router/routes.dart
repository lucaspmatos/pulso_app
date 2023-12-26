import 'package:flutter/material.dart';

import 'package:pulso_app/app/core/constants/texts.dart';

import 'package:pulso_app/app/features/monitor/view/monitor.dart';
import 'package:pulso_app/app/features/splash_screen/splash_screen.dart';

class Routes {
  static final mapRouter = {
    Texts.initialRoute: (context) => const SplashScreen(),
    Texts.monitor: (context) => const Monitor(),
  };

  static void homePageRoute(BuildContext context) =>
      Navigator.pushReplacementNamed(context, Texts.monitor);
}
