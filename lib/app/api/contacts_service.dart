import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:pulso_app/app/core/constants/constants.dart';
import 'package:pulso_app/app/features/contacts/model/contact.dart';

class ContactService {
  static const String apiUrl = '${Texts.baseUrl}/contacts/1';

  static Future<List<Contact>> getContacts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Contact.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar os contatos');
    }
  }

  static Future<void> deleteContact(int id) async {
    final response = await http.delete(Uri.parse('${Texts.baseUrl}/contact/$id'));

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Erro ao excluir o contato');
    }
  }
}