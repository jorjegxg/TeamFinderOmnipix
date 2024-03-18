import 'package:flutter/material.dart';

enum StatusOfProject { active, past }

class CustomSegmentedButton extends StatelessWidget {
  const CustomSegmentedButton(
      {super.key, required this.currentView, required this.onSelectionChanged});

  final StatusOfProject currentView;
  final Function(Set<StatusOfProject>) onSelectionChanged;
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<StatusOfProject>(
      showSelectedIcon: false,
      segments: <ButtonSegment<StatusOfProject>>[
        ButtonSegment(
          value: StatusOfProject.active,
          label: Text('Active Projects',
              style: Theme.of(context).textTheme.titleMedium),
        ),
        ButtonSegment(
          value: StatusOfProject.past,
          label: Text('Past Projects',
              style: Theme.of(context).textTheme.titleMedium),
        ),
      ],
      selected: <StatusOfProject>{currentView},
      onSelectionChanged: onSelectionChanged,
    );
  }
}
