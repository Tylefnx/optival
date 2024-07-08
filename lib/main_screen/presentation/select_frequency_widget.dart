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
            items: ['kHz', 'mHz', 'gHz'].map((String unit) {
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
