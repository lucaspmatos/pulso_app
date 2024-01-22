import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:pulso_app/app/core/constants/constants.dart';
import 'package:pulso_app/app/features/login/model/user.dart';

class LoginService {
  static const String apiUrl = '${Texts.baseUrl}/user';

  static Future<User> login(User user) async {
    final response = await http.post(
      Uri.parse('${Texts.baseUrl}/user'),
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList().first;
    } else {
      throw Exception(Texts.postHistoryException);
    }
  }
}
