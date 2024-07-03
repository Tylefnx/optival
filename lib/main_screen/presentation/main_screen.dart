import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:optival/main_screen/core/frequency_service.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FrequencyMeasurementScreen();
  }
}

class FrequencyMeasurementScreen extends StatelessWidget {
  const FrequencyMeasurementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequency Measurement'),
      ),
      body: const AnaltyzerSetup(),
    );
  }
}

class AnaltyzerSetup extends HookWidget {
  const AnaltyzerSetup({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    var avgF = useState(100);
    var avgFSelectedUnit = useState('MHz');
    ValueNotifier<List<FlSpot>> chartData = useState([]);
    var spanF = useState(100);
    var spanFSelectedUnit = useState('MHz');
    var bwF = useState(100);
    var bwFSelectedUnit = useState('MHz');
    ValueNotifier<SerialPort> serialPort = useState(SerialPort('/dev/ttyS0'));
    return Column(
      children: [
        const Text(
          'AvG',
          style: TextStyle(fontSize: 20),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SelectFrequenceWidget(
            selectedFrequencyRange: avgF,
            selectedUnit: avgFSelectedUnit,
          ),
        ),
        const Text(
          'Span',
          style: TextStyle(fontSize: 20),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SelectFrequenceWidget(
            selectedFrequencyRange: avgF,
            selectedUnit: avgFSelectedUnit,
          ),
        ),
        const Text(
          'Bandwidth',
          style: TextStyle(fontSize: 20),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SelectFrequenceWidget(
            selectedFrequencyRange: spanF,
            selectedUnit: spanFSelectedUnit,
          ),
        ),
        MeasureButton(
          chartData: chartData,
          avgF: avgF,
          avgFselectedUnit: avgFSelectedUnit,
          spanF: spanF,
          spanFselectedUnit: spanFSelectedUnit,
          serialPort: serialPort,
          bwF: bwF,
          bwFselectedUnit: bwFSelectedUnit,
        ),
        Chart(
          chartData: chartData,
        ),
      ],
    );
  }
}

class SelectFrequenceWidget extends StatelessWidget {
  const SelectFrequenceWidget({
    super.key,
    required this.selectedFrequencyRange,
    required this.selectedUnit,
  });

  final ValueNotifier<int> selectedFrequencyRange;
  final ValueNotifier<String> selectedUnit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButton<int>(
            value: selectedFrequencyRange.value,
            items: List.generate(999, (index) {
              int range = index + 1;
              return DropdownMenuItem<int>(
                value: range,
                child: Text('$range'),
              );
            }),
            onChanged: (int? newValue) {
              selectedFrequencyRange.value = newValue!;
            },
          ),
        ),
        Expanded(
          child: DropdownButton<String>(
            value: selectedUnit.value,
            items: ['kHz', 'MHz', 'GHz'].map((String unit) {
              return DropdownMenuItem<String>(
                value: unit,
                child: Text(unit),
              );
            }).toList(),
            onChanged: (String? newValue) {
              selectedUnit.value = newValue!;
            },
          ),
        ),
      ],
    );
  }
}

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
