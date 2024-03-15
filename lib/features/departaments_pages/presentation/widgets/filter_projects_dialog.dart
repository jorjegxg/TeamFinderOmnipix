import 'package:flutter/material.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_dropdown_button.dart';

class FilterProjectsDialog extends StatelessWidget {
  final String dropdownValue;
  final Function(String?) onPressed;

  const FilterProjectsDialog(
      {super.key, required this.dropdownValue, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Filter Projects',
          style: Theme.of(context).textTheme.titleLarge),
      content: SingleChildScrollView(
        child: Column(
          children: [
            CustomDropdownButton(
                elements: AppLists.projectStatusList,
                onChanged: onPressed,
                dropdownValue: dropdownValue),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Add your logic for applying the filters
            Navigator.of(context).pop();
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
