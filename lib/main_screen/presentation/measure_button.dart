import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:optival/main_screen/core/frequency_service.dart';

class MeasureButton extends StatelessWidget {
  const MeasureButton({
    super.key,
    required this.avgF,
    required this.avgFselectedUnit,
    required this.spanF,
    required this.spanFselectedUnit,
    required this.chartData,
    required this.serialPort,
    required this.bwF,
    required this.bwFselectedUnit,
  });
  final ValueNotifier<int> avgF;
  final ValueNotifier<String> avgFselectedUnit;
  final ValueNotifier<int> spanF;
  final ValueNotifier<String> spanFselectedUnit;
  final ValueNotifier<List<FlSpot>> chartData;
  final ValueNotifier<SerialPort> serialPort;
  final ValueNotifier<int> bwF;
  final ValueNotifier<String> bwFselectedUnit;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => fetchMeasurementData(
        avgF.value,
        spanF.value,
        bwF.value,
        avgFselectedUnit.value,
        spanFselectedUnit.value,
        bwFselectedUnit.value,
        chartData,
        serialPort,
      ),
      child: const Text('Measure'),
    );
  }
}
