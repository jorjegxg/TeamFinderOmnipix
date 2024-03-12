import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CopyLinkDialog extends HookWidget {
  const CopyLinkDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Add employees link',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 15),
            Text(
              'This link shall be used to add new employees to the app',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 15),
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
                    //TODO: add functionality to the add button to copy the link
                    Navigator.pop(context);
                  },
                  child: const Text('Copy'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
