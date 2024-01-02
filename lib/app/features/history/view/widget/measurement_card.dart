import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:pulso_app/app/core/constants/constants.dart';
import 'package:pulso_app/app/core/themes/text_theme.dart';
import 'package:pulso_app/app/features/history/model/cardiac_history.dart';

class MeasurementCard extends StatelessWidget {
  final CardiacHistory history;

  const MeasurementCard(this.history, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      surfaceTintColor: ColorConstants.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.favorite_rounded,
              color: Colors.pinkAccent.shade200,
              size: 75,
            ),
            const SizedBox(width: 10),
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
                      radius: 30,
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
    return DateFormat('dd/MM/yy').format(docDateTime);
  }

  String _getHour(String givenDateTime) {
    final DateTime docDateTime = DateTime.parse(givenDateTime);
    return DateFormat('HH:mm').format(docDateTime);
  }
}
