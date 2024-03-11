import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton(
      {super.key,
      required this.elements,
      this.buttonHeight,
      this.buttonWidth,
      required this.onChanged,
      required this.dropdownValue});
  final List<String> elements;
  final double? buttonHeight;
  final double? buttonWidth;
  final Function(String?) onChanged;
  final String dropdownValue;
  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  late String dropdownValue = widget.dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      value: dropdownValue,
      elevation: 16,
      style: Theme.of(context).textTheme.bodyMedium,
      borderRadius: BorderRadius.circular(12),
      onChanged: widget.onChanged,
      items: widget.elements.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
