import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:optival/main_screen/core/shared/measurement_unit.dart';
import 'package:optival/main_screen/core/srm_3006_connection_service.dart';

Future<void> fetchMeasurementData(
  int avgF,
  int spanF,
  int bwF,
  String avgFselectedUnit,
  String spanFselectedUnit,
  String bwFselectedUnit,
  ValueNotifier<List<FlSpot>> chartData,
  ValueNotifier<SerialPort> serialPort,
) async {
  sendCommand(serialPort,
      'SPECTRUM_CONFIG $avgF${unitToPowerCommand(avgFselectedUnit)},$spanF${unitToPowerCommand(spanFselectedUnit)},$bwF${unitToPowerCommand(bwFselectedUnit)},OFF,500,46;');
  sendCommand(serialPort, 'MEAS_START;');
  sendCommand(serialPort, 'MEAS_GET?');
  chartData.value = createChartData();
}
// TODO: Implement and try with the real data

List<FlSpot> createChartData() {
  final data = <Map<String, dynamic>>[
    {'frequency': 100, 'value': 50},
    {'frequency': 110, 'value': 60},
    {'frequency': 120, 'value': 40},
    {'frequency': 130, 'value': 75},
    {'frequency': 140, 'value': 90},
    {'frequency': 150, 'value': 10},
    {'frequency': 160, 'value': 30},
    {'frequency': 170, 'value': 55},
  ];
  return data.map((dataPoint) {
    return FlSpot(
      dataPoint['frequency'].toDouble(),
      dataPoint['value'].toDouble(),
    );
  }).toList();
}
