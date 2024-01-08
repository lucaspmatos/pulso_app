import 'dart:io';
import 'package:flutter/material.dart';

import 'package:pulso_app/app/router/routes.dart';
import 'package:pulso_app/app/core/themes/themes.dart';
import 'package:pulso_app/app/core/constants/constants.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  // HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Texts.appTitle,
      theme: appTheme(),
      initialRoute: Texts.initialRoute,
      routes: Routes.mapRouter,
    );
  }
}
