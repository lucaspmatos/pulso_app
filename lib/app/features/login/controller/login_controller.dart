import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:pulso_app/app/router/routes.dart';
import 'package:pulso_app/app/api/login_service.dart';
import 'package:pulso_app/app/core/constants/constants.dart';
import 'package:pulso_app/app/features/login/model/user.dart';
import 'package:pulso_app/app/features/login/contract/login_contract.dart';

class LoginControllerImpl implements LoginController {
  final LoginView _view;
  LoginControllerImpl(this._view);

  @override
  TextEditingController usernameCtl = TextEditingController();
  @override
  TextEditingController passwordCtl = TextEditingController();

  @override
  String? validateUser(String? value) {
    if (value == null || value.isEmpty) {
      return Texts.usernameMsg;
    }
    return null;
  }

  @override
  String? validatePass(String? value) {
    if (value == null || value.isEmpty) {
      return Texts.passwordMsg;
    }
    return null;
  }

  @override
  Future<bool> login() async {
    User userLogin = User(
      username: usernameCtl.text.trim(),
      age: int.tryParse(passwordCtl.text.trim()),
    );

    try {
      User? user = await LoginService.login(userLogin);
      saveUserSession(user);
      return true;
    } catch (e) {
      Fluttertoast.showToast(msg: Texts.loginExceptionMsg);
      return false;
    }
  }

  void saveUserSession(User? user) {
    UserSession.instance.user = user;
  }
}
