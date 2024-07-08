import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:optival/main_screen/core/srm_3006_connection_service.dart';
import 'package:optival/main_screen/presentation/frequency_chart.dart';
import 'package:optival/main_screen/presentation/measure_button.dart';
import 'package:optival/main_screen/presentation/select_frequency_widget.dart';

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
    var avgFSelectedUnit = useState('mHz');
    ValueNotifier<List<FlSpot>> chartData = useState([]);
    var spanF = useState(100);
    var spanFSelectedUnit = useState('mHz');
    var bwF = useState(100);
    var bwFSelectedUnit = useState('mHz');
    ValueNotifier<SerialPort> serialPort = useState(SerialPort(''));
    ValueNotifier<List<String>> availablePorts = useState([]);
    useEffect(
      () {
        initPorts(availablePorts);
        initSerialPort(serialPort, availablePorts);
        AppLifecycleListener(
          onInactive: () => serialPort.value.close,
          onResume: () => serialPort.value.close,
        );
        return;
      },
      [],
    );
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
            selectedFrequencyRange: spanF,
            selectedUnit: spanFSelectedUnit,
          ),
        ),
        const Text(
          'Bandwidth',
          style: TextStyle(fontSize: 20),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SelectFrequenceWidget(
            selectedFrequencyRange: bwF,
            selectedUnit: bwFSelectedUnit,
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
