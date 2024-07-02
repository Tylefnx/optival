import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SerialPort? _port;
  SerialPortReader? _reader;
  String _deviceInfo = "No device connected";

  @override
  void initState() {
    super.initState();
    _listDevices();
  }

  void _listDevices() {
    final availablePorts = SerialPort.availablePorts;
    if (availablePorts.isNotEmpty) {
      _deviceInfo = availablePorts[0];
      _connectToDevice(availablePorts[0]);
    } else {
      _deviceInfo = "No device connected";
    }
    setState(() {});
  }

  void _connectToDevice(String portName) {
    _port = SerialPort(portName);
    if (_port!.openReadWrite()) {
      _port!.config.baudRate = 9600; // Baud rate cihazınıza göre ayarlayın
      _reader = SerialPortReader(_port!);
      _reader!.stream.listen(_onDataReceived);
    } else {
      _deviceInfo = "Failed to open port";
      setState(() {});
    }
  }

  void _onDataReceived(Uint8List data) {
    // Cihazdan gelen veriyi işleyin
    print('Data received: ${String.fromCharCodes(data)}');
  }

  void _sendCommand(String command) {
    if (_port != null && _port!.isOpen) {
      _port!.write(Uint8List.fromList(command.codeUnits));
    }
  }

  @override
  void dispose() {
    _port?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Narda SRM-3006 Remote Command'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Device: $_deviceInfo'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _sendCommand('YOUR_COMMAND_HERE'),
                child: const Text('Send Command'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
