import 'package:flutter/material.dart';

import 'package:pulso_app/app/router/pages.dart';
import 'package:pulso_app/app/core/constants/texts.dart';

class Routes {
  static final mapRouter = {
    Texts.initialRoute: (context) => const SplashScreen(),
    Texts.monitorRoute: (context) => const Monitor(),
    Texts.historyRoute: (context) => const History(),
    Texts.contactsRoute: (context) => const Contacts(),
  };

  static void splashScreenRoute(BuildContext context) =>
      Navigator.pushReplacementNamed(context, Texts.initialRoute);

  static void monitorRoute(BuildContext context) =>
      Navigator.pushReplacementNamed(context, Texts.monitorRoute);

  static void historyRoute(BuildContext context) =>
      Navigator.pushReplacementNamed(context, Texts.historyRoute);

  static void contactsRoute(BuildContext context) =>
      Navigator.pushReplacementNamed(context, Texts.contactsRoute);
}
