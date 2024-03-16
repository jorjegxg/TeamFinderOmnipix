import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:team_finder_app/features/project_pages/data/models/technology_stack.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/suggestion_text_field.dart';

class TechnologiesDialog extends HookWidget {
  const TechnologiesDialog({
    required this.onSubmitted,
    required this.onDissmised,
    required this.name,
    required this.items,
    required this.sugestions,
    super.key,
  });
  final List<TechnologyStack> items;
  final List<TechnologyStack> sugestions;
  final Function(String) onSubmitted;
  final Function(int) onDissmised;
  final String name;
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
              name,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 15),
            SuggestionTextField(
              options: sugestions.map((e) => e.name).toList(),
              onSubmitted: (String s) {
                onSubmitted(s);
                nameColtroler.clear();
              },
              controller: nameColtroler,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      movementDuration: const Duration(milliseconds: 400),
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        onDissmised(index);
                      },
                      child: ListTile(
                        title: Text(
                          items[index].name,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
