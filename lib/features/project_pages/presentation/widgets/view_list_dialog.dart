import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ViewListDialog extends HookWidget {
  const ViewListDialog({
    required this.list,
    required this.title,
    super.key,
  });
  final List<String> list;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 15),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 15),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        list[index],
                        style: Theme.of(context).textTheme.bodyMedium,
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
