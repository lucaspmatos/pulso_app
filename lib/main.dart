import 'package:flutter/material.dart';

import 'package:pulso_app/app/router/routes.dart';
import 'package:pulso_app/app/core/themes/themes.dart';
import 'package:pulso_app/app/core/constants/constants.dart';

void main() {
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
