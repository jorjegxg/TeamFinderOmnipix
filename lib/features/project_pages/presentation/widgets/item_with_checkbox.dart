import 'package:flutter/material.dart';

class ItemWithCheckBox extends StatelessWidget {
  const ItemWithCheckBox({
    super.key,
    required this.text,
    required this.onChanged,
  });
  final String text;
  final void Function(bool?) onChanged;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: Checkbox(
        checkColor: Theme.of(context).colorScheme.primary,
        value: false,
        onChanged: onChanged,
      ),
    );
  }
}
