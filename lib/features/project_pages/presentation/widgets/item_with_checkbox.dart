import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ItemWithCheckBox extends HookWidget {
  const ItemWithCheckBox({
    required this.enabled,
    super.key,
    required this.text,
    required this.onChanged,
    required this.value,
    this.number,
    this.onSubmited,
  });
  final String text;
  final void Function(bool?, int number) onChanged;
  final bool value;
  final int? number;
  final Function(String)? onSubmited;

  final bool enabled;
  @override
  Widget build(BuildContext context) {
    final TextEditingController numberController = useTextEditingController();
    numberController.text = number.toString() ?? '0';
    return ExpansionTile(
      enabled: enabled ? value : false,
      trailing: Checkbox(
        checkColor: Colors.white,
        value: value,
        onChanged: (bool? value) {
          onChanged(
              value,
              int.parse(
                  numberController.text == '' ? '0' : numberController.text));
        },
      ),
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      children: [
        TextField(
          onSubmitted: onSubmited,
          controller: numberController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Number of people needed for this role',
          ),
        ),
      ],
    );
  }
}
