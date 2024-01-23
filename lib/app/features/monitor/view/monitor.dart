import 'dart:async';

import 'package:heart_bpm/chart.dart';
import 'package:flutter/material.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:pulso_app/app/components/components.dart';
import 'package:pulso_app/app/core/themes/text_theme.dart';
import 'package:pulso_app/app/core/constants/constants.dart';

import 'package:pulso_app/app/features/login/model/user.dart';
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
  @override
  List<SensorValue> bpmValues = [];
  List<CardiacHistory> history = <CardiacHistory>[];

  bool isBPMEnabled = false;
  late MonitorController _controller;

  int _bpm = 0;
  String _systolic = "0";
  String _diastolic = "0";
  String _bodyHeat = "0";

  _MonitorState() {
    _controller = MonitorControllerImpl(this);
  }

  @override
  void setButtonValue() {
    setState(() => isBPMEnabled ? isBPMEnabled = false : isBPMEnabled = true);

    if (isBPMEnabled) {
      _controller.subscribeTopics();
      Future.delayed(const Duration(seconds: Numbers.measurementDuration))
          .whenComplete(() => _controller.stopMeasurement());
    }

    if (!isBPMEnabled) {
      _controller.calcHistory(history);
    }
  }

  void _addHistory() {
    history.add(
      CardiacHistory(
        userId: UserSession.instance.user?.id,
        bpm: _bpm,
        systolicPressure: int.tryParse(_systolic),
        diastolicPressure: int.tryParse(_diastolic),
        bodyHeat: double.tryParse(_bodyHeat),
      ),
    );
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
      _addHistory();
    });
  }

  @override
  void setBpm(String value) {
    setState(() {
      _bpm = int.parse(value);
      bpmValues.add(
        SensorValue(
          time: DateTime.now(),
          value: _bpm.toDouble(),
        ),
      );
      _addHistory();
    });
  }

  @override
  void setDiastolicPressure(String value) => setState(() => _diastolic = value);

  @override
  void setSystolicPressure(String value) => setState(() => _systolic = value);

  @override
  void setBodyHeat(String value) => setState(() => _bodyHeat = value);

  TextStyle? _getTextStyleCard(double? fontSize) =>
      getTextTheme(context).displayLarge?.copyWith(
            color: ColorConstants.white,
            fontWeight: FontWeight.w100,
            fontSize: fontSize,
          );

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
        padding: Numbers.monitorDefaultMargin,
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width *
                (kIsWeb ? Numbers.monitorWebWidth : Numbers.monitorAppWidth),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      isBPMEnabled && !kIsWeb
                          ? HeartBPMDialog(
                              context: context,
                              cameraWidgetWidth: Numbers.zero,
                              cameraWidgetHeight: Numbers.zero,
                              onRawData: _treatData,
                              onBPM: _treatBPM,
                            )
                          : const SizedBox(),
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height *
                            Numbers.heartbeatsContainerHeight,
                        margin: Numbers.heartbeatsContainerBottomMargin,
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent.shade700,
                          borderRadius: BorderRadius.circular(Numbers.twentyFive),
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
                              style: _getTextStyleCard(Numbers.fifty),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: Numbers.two.toInt(),
                        crossAxisSpacing: Numbers.fifteen,
                        shrinkWrap: true,
                        childAspectRatio: Numbers.gridViewAspectRatio,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.pinkAccent.shade400,
                              borderRadius: BorderRadius.circular(Numbers.twentyFive),
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
                                  style: _getTextStyleCard(Numbers.fourty),
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
                              borderRadius: BorderRadius.circular(Numbers.twentyFive),
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
                                  style: _getTextStyleCard(Numbers.fourty),
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
                        margin: const EdgeInsets.only(top: Numbers.fifteen),
                        decoration: BoxDecoration(
                          color: Colors.redAccent.shade200,
                          borderRadius: BorderRadius.circular(Numbers.fifteen),
                        ),
                        alignment: Alignment.center,
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: Numbers.fifteen),
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
                      kIsWeb && bpmValues.isNotEmpty
                          ? Container(
                              margin: Numbers.chartDefaultMargin,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(
                                  Numbers.twentyFive,
                                ),
                              ),
                              constraints: const BoxConstraints.expand(height: 180),
                              child: BPMChart(bpmValues),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: setButtonValue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_rounded,
                        color: Colors.pinkAccent.shade200,
                      ),
                      const SizedBox(
                        width: Numbers.ten,
                      ),
                      Text(
                        isBPMEnabled ? Texts.stopMeasurement : Texts.measureBPM,
                        style: getTextTheme(context).bodyMedium?.copyWith(
                          color: Colors.pinkAccent.shade200,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
