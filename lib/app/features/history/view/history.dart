import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pulso_app/app/core/themes/themes.dart';
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
  void reloadPage() => setState(() {});

  Widget _errorWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.history,
          size: Numbers.hundred,
          color: Colors.pinkAccent.shade200,
        ),
        const Text(Texts.historyError),
      ],
    );
  }

  Widget _loadPage(
    BuildContext context,
    AsyncSnapshot<List<CardiacHistory>?> snapshot,
  ) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.pinkAccent.shade200,
            ),
            const Text(
              Texts.loadingHistory,
              style: TextStyle(height: Numbers.four),
            ),
          ],
        ),
      );
    }
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return _errorWidget();
      } else if (snapshot.hasData) {
        history = snapshot.data;
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: history!.length,
                itemBuilder: (context, index) {
                  final historyItem = history![index];
                  if (index == history!.length - 1) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: Numbers.twenty),
                      child: MeasurementCard(
                        historyItem,
                        () => _controller.sendWhatsApp(historyItem),
                        () => _controller.deleteHistory(historyItem.id!),
                      ),
                    );
                  }
                  return MeasurementCard(
                    historyItem,
                    () => _controller.sendWhatsApp(historyItem),
                    () => _controller.deleteHistory(historyItem.id!),
                  );
                },
              ),
            ),
            if (kIsWeb)...[
              ElevatedButton(
                onPressed: _controller.deleteAllHistory,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.heartCircleXmark,
                      color: Colors.pinkAccent.shade200,
                    ),
                    const SizedBox(
                      width: Numbers.ten,
                    ),
                    Text(
                      Texts.deleteAllHistory,
                      style: getTextTheme(context).bodyMedium?.copyWith(
                        color: Colors.pinkAccent.shade200,
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ],
        );
      }
    }
    return _errorWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: DrawerAppBar(
        title: Texts.history,
        context: context,
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width *
              (kIsWeb ? Numbers.monitorWebWidth : Numbers.monitorAppWidth),
          child: FutureBuilder<List<CardiacHistory>?>(
            future: _controller.loadHistory(),
            builder: _loadPage,
          ),
        ),
      ),
    );
  }
}
