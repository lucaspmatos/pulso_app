import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:pulso_app/app/core/themes/text_theme.dart';
import 'package:pulso_app/app/core/constants/constants.dart';
import 'package:pulso_app/app/features/history/model/cardiac_history.dart';

class MeasurementCard extends StatelessWidget {
  final CardiacHistory history;

  const MeasurementCard(this.history, {super.key});

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
        child: Row(
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
                              style: getTextTheme(context).bodySmall?.copyWith(
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
                              style: getTextTheme(context).bodySmall?.copyWith(
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
                        style: getTextTheme(context).headlineSmall?.copyWith(
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
      ),
    );
  }

  String _getDate(String givenDateTime) {
    final DateTime docDateTime = DateTime.parse(givenDateTime);
    return DateFormat(Texts.historyDateFormat).format(docDateTime);
  }

  String _getHour(String givenDateTime) {
    final DateTime docDateTime = DateTime.parse(givenDateTime);
    return DateFormat(Texts.historyTimeFormat).format(docDateTime);
  }
}
