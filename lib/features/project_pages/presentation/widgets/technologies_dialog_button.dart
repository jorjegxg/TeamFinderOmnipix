import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/suggestion_text_field.dart';

class TechnologiesDialog extends HookWidget {
  const TechnologiesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameColtroler = useTextEditingController();

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
            SuggestionTextField(
              options: ['asdas'],
              onSubmitted: (String) {
                //TODO: add functionality to the text field,add the text to the list
              },
              controller: nameColtroler,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Slidable(
                      key: const ValueKey(0),
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),

                        // A pane can dismiss the Slidable.
                        dismissible: DismissiblePane(onDismissed: () {}),

                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                            onPressed: (BuildContext context) {},
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          'Item $index',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
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
