import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FieldDialog extends HookWidget {
  const FieldDialog({
    Key? key,
    required this.text1,
    this.text2,
    required this.title,
    required this.onPress,
    this.initialText1,
    this.initialText2,
  }) : super(key: key);
  final String text1;
  final String? text2;
  final String title;
  final Function(String t1, String? t2) onPress;
  final String? initialText1;
  final String? initialText2;
  @override
  Widget build(BuildContext context) {
    final firstController = useTextEditingController(
      text: initialText1,
    );
    final secondController = useTextEditingController(
      text: initialText2,
    );
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: firstController,
              decoration: InputDecoration(
                labelText: text1,
              ),
            ),
            if (text2 != null)
              TextField(
                controller: secondController,
                decoration: InputDecoration(
                  labelText: text2,
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
                TextButton(
                  onPressed: () {
                    onPress(firstController.text, secondController.text);
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
