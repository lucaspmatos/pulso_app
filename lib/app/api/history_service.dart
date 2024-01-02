import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:pulso_app/app/core/constants/constants.dart';
import 'package:pulso_app/app/features/history/model/cardiac_history.dart';

class HistoryService {
  static const String apiUrl = '${Texts.baseUrl}/contacts/1';

  static Future<List<CardiacHistory>> getHistory() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => CardiacHistory.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar o histórico');
    }
  }

  static Future<void> postHistory(CardiacHistory history) async {
    final response = await http.post(
      Uri.parse(
        '${Texts.baseUrl}/cardiac_history/${history.userId}',
      ),
      body: history,
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Erro ao incluir histórico');
    }
  }
}
