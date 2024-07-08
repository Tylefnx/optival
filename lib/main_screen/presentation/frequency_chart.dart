import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({
    super.key,
    required this.chartData,
  });

  final ValueNotifier<List<FlSpot>> chartData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: chartData.value,
                isCurved: true,
                barWidth: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
