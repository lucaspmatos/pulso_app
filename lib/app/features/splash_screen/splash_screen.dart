import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pulso_app/app/router/routes.dart';
import 'package:pulso_app/app/core/themes/text_theme.dart';
import 'package:pulso_app/app/core/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: Numbers.three),
      () => Routes.monitorRoute(context),
    );
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
            CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.pinkAccent.shade100),
            ),
          ],
        ),
      ),
    );
  }
}
