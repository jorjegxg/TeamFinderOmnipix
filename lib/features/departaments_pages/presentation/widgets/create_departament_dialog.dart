import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_dropdown_button.dart';

class CreateDepartamentDialog extends HookWidget {
  const CreateDepartamentDialog({
    super.key,
    required this.onSubmitted,
    required this.onChanged,
    required this.elements,
    required this.dropdownValue,
  });

  final Function(String) onSubmitted;
  final Function(String?) onChanged;
  final List<String> elements;
  final String dropdownValue;

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameConttroler = useTextEditingController();
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
            CustomTextField(
              nameConttroler: nameConttroler,
              onSubmitted: onSubmitted,
              width: 100.w,
            ),
            SizedBox(height: 15),
            CustomDropdownButton(
              elements: elements,
              onChanged: onChanged,
              dropdownValue: dropdownValue,
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
