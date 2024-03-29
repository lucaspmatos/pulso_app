import 'package:flutter/material.dart';

abstract class LoginView {}

abstract class LoginController {
  late final TextEditingController usernameCtl;
  late final TextEditingController passwordCtl;

  void dispose();
  Future<bool> login();
  String? validateUser(String? value);
  String? validatePass(String? value);
}