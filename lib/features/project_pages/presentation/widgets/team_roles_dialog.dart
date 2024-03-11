import 'package:flutter/material.dart';

class TeamRolesDialog extends StatelessWidget {
  const TeamRolesDialog({super.key});

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
              'Add team roles',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 15),
            Text(
              '   In this screen you shall be able to add team roles to your project. You can add as many as you want.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        'Item $index',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Checkbox(
                        checkColor: Theme.of(context).colorScheme.primary,
                        value: false,
                        onChanged: (bool? value) {
                          //TODO: add functionality to the checkbox
                        },
                      ),
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
