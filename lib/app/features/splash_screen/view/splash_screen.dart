import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:pulso_app/app/router/routes.dart';
import 'package:pulso_app/app/core/themes/text_theme.dart';
import 'package:pulso_app/app/core/constants/constants.dart';

import 'package:pulso_app/app/features/splash_screen/contract/splash_contract.dart';
import 'package:pulso_app/app/features/splash_screen/controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> implements SplashView {
  late final SplashController _controller;

  _SplashScreenState() {
    _controller = SplashControllerImpl(this);
  }

  @override
  void goToMonitor() => Routes.monitorRoute(context);

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      Timer(
        const Duration(seconds: Numbers.three),
        () => Routes.monitorRoute(context),
      );
      return;
    }
    _controller.subscribeTopic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.favorite_rounded,
              color: Colors.pinkAccent.shade400,
              size: Numbers.heartbeatIconSize,
            ),
            Text(
              Texts.appTitle,
              style: getTextTheme(context).displayLarge?.copyWith(
                    fontFamily: GoogleFonts.lato().fontFamily,
                    color: Colors.pinkAccent.shade200,
                  ),
            ),
            Text(
              Texts.slogan,
              style: getTextTheme(context).bodyLarge?.copyWith(
                    height: Numbers.two,
                  ),
            ),
            const SizedBox(height: Numbers.hundred),
            Visibility(
              visible: !kIsWeb,
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.pinkAccent.shade100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
