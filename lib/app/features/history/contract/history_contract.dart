import 'package:pulso_app/app/features/history/model/cardiac_history.dart';

abstract class HistoryView {
  void loadHistory(List<CardiacHistory> contacts);
}

abstract class HistoryController {
  void screenOpened();
}