String unitToPowerCommand(String unit) {
  switch (unit) {
    case 'kHz':
      return 'e3';
    case 'mHz':
      return 'e6';
    case 'gHz':
      return 'e9';
    default:
      print('Invalid Freq');
  }
  return '';
}

int unitToPower(String unit) {
  switch (unit) {
    case 'kHz':
      return 3;
    case 'mHz':
      return 6;
    case 'gHz':
      return 9;
    default:
      print('Invalid Freq');
  }
  return 0;
}
