import 'package:flutter/material.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/item_with_checkbox.dart';

class TeamRolesDialog extends StatelessWidget {
  const TeamRolesDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.items,
      required this.onChanged});

  final String title;
  final String description;
  final List<String> items;
  final Function(bool?) onChanged;
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
                      text: items[index],
                      onChanged: onChanged,
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
