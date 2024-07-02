import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FrequencyMeasurementScreen();
  }
}

Future<void> _fetchMeasurementData(int selectedFrequencyRange,
    String selectedUnit, ValueNotifier<List<FlSpot>> chartData) async {
  chartData.value = createChartData();
}

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

class FrequencyMeasurementScreen extends HookWidget {
  const FrequencyMeasurementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var selectedFrequencyRange = useState(100);
    var selectedUnit = useState('MHz');
    ValueNotifier<List<FlSpot>> chartData = useState([]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequency Measurement'),
      ),
      body: Column(
        children: [
          DropdownButton<int>(
            value: selectedFrequencyRange.value,
            items: List.generate(10, (index) {
              int range = (index + 1) * 100;
              return DropdownMenuItem<int>(
                value: range,
                child: Text('$range Hz'),
              );
            }),
            onChanged: (int? newValue) {
              selectedFrequencyRange.value = newValue!;
            },
          ),
          DropdownButton<String>(
            value: selectedUnit.value,
            items: ['MHz', 'GHz'].map((String unit) {
              return DropdownMenuItem<String>(
                value: unit,
                child: Text(unit),
              );
            }).toList(),
            onChanged: (String? newValue) {
              selectedUnit.value = newValue!;
            },
          ),
          ElevatedButton(
            onPressed: () => _fetchMeasurementData(
                selectedFrequencyRange.value, selectedUnit.value, chartData),
            child: const Text('Measure'),
          ),
          Expanded(
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
          ),
        ],
      ),
    );
  }
}
