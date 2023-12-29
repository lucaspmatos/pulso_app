import 'package:flutter/material.dart';
import 'package:heart_bpm/chart.dart';
import 'package:heart_bpm/heart_bpm.dart';

import 'package:pulso_app/app/components/components.dart';
import 'package:pulso_app/app/core/constants/constants.dart';

import 'package:pulso_app/app/features/monitor/contract/monitor_contract.dart';
import 'package:pulso_app/app/features/monitor/controller/monitor_controller.dart';

class Monitor extends StatefulWidget {
  const Monitor({super.key});

  @override
  _MonitorState createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> {
  List<SensorValue> data = [];
  List<SensorValue> bpmValues = [];
  //  Widget chart = BPMChart(data);

  bool isBPMEnabled = false;
  Widget? dialog;
  late MonitorController _controller;

  _MonitorState() {
    _controller = MonitorControllerImpl();
  }

  void _toggleBPM() {
    setState(() => isBPMEnabled ? isBPMEnabled = false : isBPMEnabled = true);

    if (!isBPMEnabled && bpmValues.isNotEmpty) {
      _controller.calcBPM(bpmValues);
    }
  }

  void _treatData(SensorValue value) {
    setState(() {
      if (data.length >= 100) data.removeAt(0);
      data.add(value);
    });
  }

  void _treatBPM(int value) {
    setState(() {
      if (bpmValues.length >= 100) bpmValues.removeAt(0);
      bpmValues.add(
        SensorValue(
          value: value.toDouble(),
          time: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: DrawerAppBar(
        title: Texts.monitor,
        context: context,
      ),
      drawer: const AppDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isBPMEnabled
              ? dialog = HeartBPMDialog(
                  context: context,
                  cameraWidgetWidth: 50,
                  cameraWidgetHeight: 50,
                  showTextValues: true,
                  borderRadius: 25,
                  onRawData: _treatData,
                  onBPM: _treatBPM,
                )
              : const SizedBox(),
          isBPMEnabled && bpmValues.isNotEmpty
              ? Container(
                  decoration: BoxDecoration(border: Border.all()),
                  constraints: const BoxConstraints.expand(height: 180),
                  child: BPMChart(bpmValues),
                )
              : const SizedBox(),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.favorite_rounded),
              label: Text(isBPMEnabled ? "Stop measurement" : "Measure BPM"),
              onPressed: _toggleBPM,
            ),
          ),
        ],
      ),
    );
  }
}
