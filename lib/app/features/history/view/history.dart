import 'package:flutter/material.dart';

import 'package:pulso_app/app/components/components.dart';
import 'package:pulso_app/app/core/constants/constants.dart';

import 'package:pulso_app/app/features/history/model/cardiac_history.dart';
import 'package:pulso_app/app/features/history/contract/history_contract.dart';
import 'package:pulso_app/app/features/history/view/widget/measurement_card.dart';
import 'package:pulso_app/app/features/history/controller/history_controller.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> implements HistoryView {
  late final HistoryController _controller;
  List<CardiacHistory>? history;

  _HistoryState() {
    _controller = HistoryControllerImpl(this);
  }

  @override
  void initState() {
    super.initState();
    _controller.screenOpened();
  }

  @override
  void loadHistory(List<CardiacHistory> historyList) {
    setState(() => history = historyList);
  }

  Widget _loadPage(List<CardiacHistory>? history) {
    if (history != null) {
      return ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final historyItem = history[index];
          if (history.isNotEmpty) {
            return MeasurementCard(historyItem);
          }
          return const Center(
            child: ListTile(
              title: Text(Texts.historyError),
            ),
          );
        },
      );
    }

    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Text(
            Texts.loadingHistory,
            style: TextStyle(height: 4),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: DrawerAppBar(
        title: Texts.contacts,
        context: context,
      ),
      drawer: const AppDrawer(),
      body: _loadPage(history),
    );
  }
}
