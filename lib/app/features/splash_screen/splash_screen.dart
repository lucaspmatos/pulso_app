import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, 'home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(color: Color(0xFF3a3940)),
      child: Column(
        children: <Widget>[
          const Spacer(),
          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/Pulsify.gif'),
                    fit: BoxFit.cover)),
          ),
          const Spacer(
            flex: 2,
          ),
          const CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFff0000)),
          ),
          const Spacer(),
        ],
      ),
    ));
  }
}
