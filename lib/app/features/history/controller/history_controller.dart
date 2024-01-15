import 'package:fluttertoast/fluttertoast.dart';

import 'package:pulso_app/app/api/history_service.dart';
import 'package:pulso_app/app/core/constants/constants.dart';
import 'package:pulso_app/app/features/history/model/cardiac_history.dart';
import 'package:pulso_app/app/features/history/contract/history_contract.dart';

class HistoryControllerImpl implements HistoryController {
  final HistoryView _view;

  HistoryControllerImpl(this._view);

  Future<void> _loadHistory() async {
    try {
      List<CardiacHistory> fetchedHistory = await HistoryService.getHistory();
      _view.loadHistory(fetchedHistory);
    } catch (e) {
      Fluttertoast.showToast(msg: Texts.loadHistoryMsg);
    }
  }

  @override
  void screenOpened() {
    _loadHistory();
  }
}
