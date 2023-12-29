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
    Timer(const Duration(seconds: 3), () => Routes.monitorRoute(context));
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
              color: Colors.deepPurple.shade400,
              size: 90,
            ),
            Text(
              Texts.appTitle,
              style: getTextTheme(context).displayLarge?.copyWith(
                fontFamily: GoogleFonts.lato().fontFamily,
                color: Colors.deepPurple.shade400,
              ),
            ),
            Text(
              Texts.slogan,
              style: getTextTheme(context).bodyLarge?.copyWith(
                height: 2,
              ),
            ),
            const SizedBox(height: 100),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.deepPurple.shade400
              ),
            ),
          ],
        ),
      ),
    );
  }
}
