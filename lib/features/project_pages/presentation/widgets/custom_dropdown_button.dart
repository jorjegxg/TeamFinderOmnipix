import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton(
      {super.key, required this.elements, this.buttonHeight, this.buttonWidth});
  final List<String> elements;
  final double? buttonHeight;
  final double? buttonWidth;

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  late String dropdownValue;
  @override
  void initState() {
    dropdownValue = widget.elements.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      menuHeight: widget.buttonHeight,
      width: widget.buttonWidth,
      initialSelection: widget.elements.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries:
          widget.elements.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
