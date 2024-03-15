import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FieldDialog extends HookWidget {
  const FieldDialog({
    Key? key,
    required this.text1,
    this.text2,
    required this.title,
    required this.onPress,
  }) : super(key: key);
  final String text1;
  final String? text2;
  final String title;
  final Function() onPress;
  @override
  Widget build(BuildContext context) {
    final firstController = useTextEditingController();
    final secondController = useTextEditingController();
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
                  onPressed: onPress,
                  child: const Text('Edit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
