import 'package:http/http.dart' as http;
import 'package:pulso_app/app/core/constants/constants.dart';

class MonitorService {
  static Future<void> sendMessage(String msg) async {
    String apiUrl = Texts.whatsAppUrl(Texts.phone, msg, Texts.apiKey);
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception(Texts.whatsAppMsgException);
    }
  }
}