import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:optival/main_screen/core/shared/int2str_converter.dart';

void initPorts(ValueNotifier<List<String>> availablePorts,
    ValueNotifier<SerialPort> serialPort) {
  availablePorts.value = SerialPort.availablePorts;
  if (availablePorts.value != []) {
    serialPort.value = SerialPort(availablePorts.value.first);
  }
  print(availablePorts.value);
}

void sendCommand(ValueNotifier<SerialPort> serialPort, String command) {
  serialPort.value.openWrite();
  var cmd = convertStringToUint8List(command);
  serialPort.value.write(cmd);
  serialPort.value.close();
  return;
}

void readData(ValueNotifier<SerialPort> serialPort) {
  final reader = SerialPortReader(serialPort.value);
  reader.stream.listen((data) {});
}
