import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FilterDialog extends HookWidget {
  const FilterDialog(
      {required this.onChanged,
      required this.value,
      required this.partiallyAvailable,
      required this.isUnavailable,
      required this.closeToFinish,
      required this.onPartiallyAvailable,
      required this.onIsUnavailable,
      required this.onCloseToFinish,
      required this.onAdd,
      super.key});

  final bool partiallyAvailable;
  final bool isUnavailable;
  final bool closeToFinish;
  final Function(bool?) onPartiallyAvailable;
  final Function(bool?) onIsUnavailable;
  final Function(bool?) onCloseToFinish;
  final Function(double) onChanged;
  final double value;
  final Function() onAdd;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'Filter Employees',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Partially Available',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Checkbox(
                    value: partiallyAvailable, onChanged: onPartiallyAvailable),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Unavailable',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Checkbox(value: isUnavailable, onChanged: onIsUnavailable),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Close To Finish',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Checkbox(value: closeToFinish, onChanged: onCloseToFinish),
              ],
            ),
            const SizedBox(height: 15),
            Slider(
              value: value,
              onChanged: onChanged,
              divisions: 8,
              min: 0,
              max: 8,
            ),
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
                    onAdd();
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
