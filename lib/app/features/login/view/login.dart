import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:pulso_app/app/router/routes.dart';
import 'package:pulso_app/app/core/themes/text_theme.dart';
import 'package:pulso_app/app/core/constants/constants.dart';

import 'package:pulso_app/app/features/login/contract/login_contract.dart';
import 'package:pulso_app/app/features/login/controller/login_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> implements LoginView {
  late final LoginController _controller;
  final _formKey = GlobalKey<FormState>();

  _LoginState() {
    _controller = LoginControllerImpl(this);
  }

  void _loginClick() async {
    if (_formKey.currentState!.validate()) {
      final bool isLogged = await _controller.login();
      if (isLogged) _goToSplashScreen();
    }
  }

  void _goToSplashScreen() => Routes.splashScreenRoute(context);

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Texts.appTitle,
          style: getTextTheme(context).headlineMedium?.copyWith(
                fontFamily: GoogleFonts.lato().fontFamily,
                color: Colors.pinkAccent.shade400,
              ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width *
                (kIsWeb ? Numbers.monitorWebWidth : Numbers.monitorAppWidth),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _controller.usernameCtl,
                          decoration: InputDecoration(
                            labelStyle:
                                getTextTheme(context).bodyMedium?.copyWith(
                                      color: Colors.pinkAccent.shade200,
                                    ),
                            labelText: Texts.username,
                          ),
                          validator: _controller.validateUser,
                        ),
                        TextFormField(
                          controller: _controller.passwordCtl,
                          decoration: InputDecoration(
                            labelStyle:
                                getTextTheme(context).bodyMedium?.copyWith(
                                      color: Colors.pinkAccent.shade200,
                                    ),
                            labelText: Texts.password,
                          ),
                          obscureText: true,
                          validator: _controller.validatePass,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _loginClick,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_rounded,
                          color: Colors.pinkAccent.shade200,
                        ),
                        const SizedBox(
                          width: Numbers.ten,
                        ),
                        Text(
                          Texts.enter,
                          style: getTextTheme(context).bodyMedium?.copyWith(
                                color: Colors.pinkAccent.shade200,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
