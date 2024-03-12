import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FilterDialog extends HookWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    bool partiallyAvailable = false;
    bool unavaileble = false;
    bool closeToFinish = false;

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
                    value: partiallyAvailable,
                    onChanged: (newValue) {
                      partiallyAvailable = newValue!;
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Unavailable',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Checkbox(
                    value: unavaileble,
                    onChanged: (newValue) {
                      unavaileble = newValue!;
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Close To Finish',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Checkbox(
                    value: closeToFinish,
                    onChanged: (newValue) {
                      closeToFinish = newValue!;
                    }),
              ],
            ),
            const SizedBox(height: 15),
            Slider(
              value: 4,
              onChanged: (newValue) {
                //TODO: add functionality to the slider
                //max value should be how in many weeks the employee is available
              },
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
                    //TODO: add functionality to the add button
                    Navigator.pop(context);
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
