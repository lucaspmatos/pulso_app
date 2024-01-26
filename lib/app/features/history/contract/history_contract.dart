import 'package:pulso_app/app/features/history/model/cardiac_history.dart';

abstract class HistoryView {
  void reloadPage();
}

abstract class HistoryController {
  void screenOpened();
  void deleteHistory(int id);
  void sendWhatsApp(CardiacHistory report);
  Future<List<CardiacHistory>?> loadHistory();
}