import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:heart_bpm/chart.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pulso_app/app/core/themes/text_theme.dart';
import 'package:pulso_app/app/core/constants/constants.dart';
import 'package:pulso_app/app/features/history/model/cardiac_history.dart';

class MeasurementCard extends StatelessWidget {
  final CardiacHistory history;
  final VoidCallback onTapWhatsApp;
  final VoidCallback onTapDelete;

  const MeasurementCard(
    this.history,
    this.onTapWhatsApp,
    this.onTapDelete, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Numbers.measurementCardMargin,
      surfaceTintColor: ColorConstants.white,
      elevation: Numbers.two,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Numbers.four),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: Numbers.measurementCardPadding,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.favorite_rounded,
                  color: Colors.pinkAccent.shade200,
                  size: Numbers.heartbeatIconSize,
                ),
                const SizedBox(width: Numbers.ten),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _getDate(history.createdAt ?? Texts.noData),
                            style: getTextTheme(context).bodySmall,
                          ),
                          Text(
                            _getHour(history.createdAt ?? Texts.noData),
                            style: getTextTheme(context).bodySmall,
                          ),
                        ],
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          Texts.heartbeats,
                          style: getTextTheme(context).bodyMedium?.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Texts.heartPressure,
                                  style: getTextTheme(context).bodySmall,
                                ),
                                Text(
                                  history.systolicPressure != null
                                      ? '${history.systolicPressure.toString()} x ${history.diastolicPressure.toString()}'
                                      : Texts.noData,
                                  style:
                                      getTextTheme(context).bodySmall?.copyWith(
                                            color: Colors.pinkAccent.shade400,
                                          ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Texts.temperature,
                                  style: getTextTheme(context).bodySmall,
                                ),
                                Text(
                                  history.bodyHeat != null
                                      ? '${history.bodyHeat.toString()} ${Texts.celsius}'
                                      : Texts.noData,
                                  style:
                                      getTextTheme(context).bodySmall?.copyWith(
                                            color: Colors.redAccent.shade200,
                                          ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: CircleAvatar(
                          radius: Numbers.heartbeatRadius,
                          backgroundColor: Colors.pinkAccent.shade700,
                          child: Text(
                            history.bpm.toString(),
                            style:
                                getTextTheme(context).headlineSmall?.copyWith(
                                      color: ColorConstants.white,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (kIsWeb && history.bpmValues != null) ...[_renderBPMChart()],
            if (!kIsWeb) ...[
              const Divider(color: ColorConstants.lightGrey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: onTapWhatsApp,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.teal.shade700,
                          ),
                          const SizedBox(
                            width: Numbers.five,
                          ),
                          Text(
                            Texts.sendReport,
                            style: getTextTheme(context).bodySmall?.copyWith(
                                  color: Colors.teal.shade700,
                                  fontSize: Numbers.fourteen,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: onTapDelete,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete_forever,
                            color: Colors.pinkAccent.shade200,
                          ),
                          const SizedBox(
                            width: Numbers.five,
                          ),
                          Text(
                            Texts.deleteHistory,
                            style: getTextTheme(context).bodySmall?.copyWith(
                                  color: Colors.pinkAccent.shade200,
                                  fontSize: Numbers.fourteen,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _renderBPMChart() {
    List<SensorValue> chartList =
        history.bpmValues!.map((e) => ParseSensor.fromJson(e)).toList();
    return Column(
        children: [
          const SizedBox(height: Numbers.fifteen),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorConstants.lightGrey,
              ),
              borderRadius: BorderRadius.circular(
                Numbers.ten,
              ),
            ),
            constraints: const BoxConstraints.expand(
              height: Numbers.drawerWebSize,
            ),
            child: BPMChart(chartList),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(chartList.first.value.toString()),
              Text(chartList.last.value.toString()),
            ],
          ),
        ],
      );
  }

  String _getDate(String givenDateTime) {
    final DateTime docDateTime = DateTime.parse(givenDateTime).toLocal();
    return DateFormat(Texts.historyDateFormat, 'pt-BR').format(docDateTime);
  }

  String _getHour(String givenDateTime) {
    final DateTime docDateTime = DateTime.parse(givenDateTime).toLocal();
    return DateFormat(Texts.historyTimeFormat, 'pt-BR').format(docDateTime);
  }
}
