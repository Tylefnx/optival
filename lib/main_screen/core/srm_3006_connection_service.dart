import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:optival/main_screen/core/shared/int2str_converter.dart';

void initPorts(ValueNotifier<List<String>> availablePorts) {
  availablePorts.value = SerialPort.availablePorts;
}

void initSerialPort(ValueNotifier<SerialPort> serialPort,
    ValueNotifier<List<String>> availablePorts) {
  if (availablePorts.value != []) {
    serialPort.value = SerialPort(availablePorts.value.first);
  }
  final config = SerialPortConfig();

  // Baud rate'i ayarlayın
  config.baudRate = 115200;

  // Diğer seri port ayarları
  config.bits = 8;
  config.parity = SerialPortParity.none;
  config.stopBits = 1;

  // Seri portu konfigüre edin
  serialPort.value.config = config;

  // Seri portu açın
  if (!serialPort.value.openReadWrite()) {
    print(SerialPort.lastError);
  } else {
    print('Serial port opened successfully.');
  }
}

void sendCommand(ValueNotifier<SerialPort> serialPort, String command) {
  print('works');
  serialPort.value.openWrite();
  print('successfully opened port');
  var cmd = convertStringToUint8List(command);
  serialPort.value.write(cmd);
  serialPort.value.close();
  return;
}

void readData(ValueNotifier<SerialPort> serialPort) {
  final reader = SerialPortReader(serialPort.value);
  reader.stream.listen((data) {
    print(data);
  });
}
