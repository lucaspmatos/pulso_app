import 'package:flutter/material.dart';

import 'package:pulso_app/app/core/constants/constants.dart';
import 'package:pulso_app/app/features/history/model/cardiac_history.dart';

class MeasurementCard extends StatelessWidget {
  final CardiacHistory history;

  const MeasurementCard(this.history, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Medição',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _measurementItem(
                  Texts.heartbeats,
                  history.bpm,
                  'bpm',
                ),
                _measurementItem(
                  Texts.systolicPressure,
                  history.systolicPressure,
                  Texts.pressureMeasure,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _measurementItem(
                  Texts.diastolicPressure,
                  history.diastolicPressure,
                  Texts.pressureMeasure,
                ),
                _measurementItem(
                  Texts.bodyHeat,
                  history.bodyHeat,
                  Texts.celsius,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              history.createdAt?.toIso8601String() ?? Texts.noData,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _measurementItem(String label, dynamic valor, String unidade) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          _getValueText(valor),
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          unidade,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  String _getValueText(dynamic value) => value ?? Texts.noData;
}
