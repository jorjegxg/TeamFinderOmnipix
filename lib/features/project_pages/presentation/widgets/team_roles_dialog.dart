import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/item_with_checkbox.dart';

class TeamRolesDialog extends HookWidget {
  const TeamRolesDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.items,
      required this.onChanged});

  final String title;
  final String description;
  final Map<Map<String, int>, bool> items;
  final Function(bool?, int index, int number) onChanged;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 15),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ItemWithCheckBox(
                      value: items.values.elementAt(index),
                      text: items.keys.elementAt(index).keys.first,
                      onChanged: (bool? value, int number) {
                        onChanged(value, index, number);
                      },
                      enabled: true,
                      number: items.keys.elementAt(index).values.first,
                      onSubmited: (String s) {
                        onChanged(
                          items.values.elementAt(index),
                          index,
                          int.parse(s),
                        );
                      },
                    );
                  }),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
