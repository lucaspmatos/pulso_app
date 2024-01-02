import 'dart:async';

import 'package:heart_bpm/chart.dart';
import 'package:flutter/material.dart';
import 'package:heart_bpm/heart_bpm.dart';

import 'package:pulso_app/app/components/components.dart';
import 'package:pulso_app/app/core/themes/text_theme.dart';
import 'package:pulso_app/app/core/constants/constants.dart';

import 'package:pulso_app/app/features/history/model/cardiac_history.dart';
import 'package:pulso_app/app/features/monitor/contract/monitor_contract.dart';
import 'package:pulso_app/app/features/monitor/controller/monitor_controller.dart';

class Monitor extends StatefulWidget {
  const Monitor({super.key});

  @override
  _MonitorState createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> implements MonitorView {
  List<SensorValue> data = [];
  List<SensorValue> bpmValues = [];

  bool isBPMEnabled = false;
  late MonitorController _controller;

  int _bpm = 0;
  String _systolic = "0";
  String _diastolic = "0";
  String _bodyHeat = "0";

  _MonitorState() {
    _controller = MonitorControllerImpl(this);
  }

  void _toggleBPM() {
    setState(() => isBPMEnabled ? isBPMEnabled = false : isBPMEnabled = true);

    if (isBPMEnabled) _controller.subscribeTopics();

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
      _bpm = value;

      if (bpmValues.length >= 100) bpmValues.removeAt(0);
      bpmValues.add(
        SensorValue(
          value: value.toDouble(),
          time: DateTime.now(),
        ),
      );
    });

    Timer(const Duration(seconds: 15), () {
      _controller.stopMeasurement(
        CardiacHistory(
          userId: 1,
          bpm: _bpm,
          systolicPressure: int.tryParse(_systolic),
          diastolicPressure: int.tryParse(_diastolic),
          bodyHeat: double.tryParse(_bodyHeat),
        )
      );
    });
  }

  @override
  void setButtonValue() => setState(() => isBPMEnabled = false);

  @override
  setBodyHeat(String value) => setState(() => _bodyHeat = value);

  @override
  setDiastolicPressure(String value) => setState(() => _diastolic = value);

  @override
  setSystolicPressure(String value) => setState(() => _systolic = value);

  TextStyle? _getTextStyleCard(double? fontSize) {
    return getTextTheme(context).displayLarge?.copyWith(
          color: ColorConstants.white,
          fontWeight: FontWeight.w100,
          fontSize: fontSize,
        );
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
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isBPMEnabled
                ? HeartBPMDialog(
                    context: context,
                    cameraWidgetWidth: 0,
                    cameraWidgetHeight: 0,
                    onRawData: _treatData,
                    onBPM: _treatBPM,
                  )
                : const SizedBox(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.pinkAccent.shade700,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Align(
                alignment: Alignment.center,
                child: ListTile(
                  title: Text(
                    Texts.heartbeats,
                    textAlign: TextAlign.center,
                    style: getTextTheme(context).displaySmall?.copyWith(
                          color: ColorConstants.white,
                        ),
                  ),
                  subtitle: Text(
                    _bpm.toString(),
                    style: _getTextStyleCard(50),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              shrinkWrap: true,
              childAspectRatio: 1.5,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent.shade400,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Texts.systolicPressure,
                        textAlign: TextAlign.center,
                        style: getTextTheme(context).bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.white,
                            ),
                      ),
                      Text(
                        _systolic,
                        style: _getTextStyleCard(40),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        Texts.pressureMeasure,
                        style: getTextTheme(context).bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.white,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent.shade200,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Texts.diastolicPressure,
                        textAlign: TextAlign.center,
                        style: getTextTheme(context).bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.white,
                            ),
                      ),
                      Text(
                        _diastolic,
                        style: _getTextStyleCard(40),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        Texts.pressureMeasure,
                        style: getTextTheme(context).bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.white,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Colors.redAccent.shade200,
                borderRadius: BorderRadius.circular(15),
              ),
              alignment: Alignment.center,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                title: Text(
                  Texts.bodyHeat,
                  style: getTextTheme(context).bodySmall?.copyWith(
                        color: ColorConstants.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                trailing: Text(
                  "$_bodyHeat${Texts.celsius}",
                  style: getTextTheme(context).displayLarge?.copyWith(
                        color: ColorConstants.white,
                        fontWeight: FontWeight.w100,
                        fontSize: 25,
                      ),
                ),
              ),
            ),

            // isBPMEnabled && bpmValues.isNotEmpty
            //     ? Container(
            //         decoration: BoxDecoration(border: Border.all()),
            //         constraints: const BoxConstraints.expand(height: 180),
            //         child: BPMChart(bpmValues),
            //       )
            //     : const SizedBox(),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.favorite_rounded),
                label: Text(
                  isBPMEnabled ? Texts.stopMeasurement : Texts.measureBPM,
                ),
                onPressed: _toggleBPM,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
