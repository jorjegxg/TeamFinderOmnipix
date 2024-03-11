import 'package:flutter/material.dart';

class CustomSegmentedButton extends StatefulWidget {
  const CustomSegmentedButton({super.key});

  @override
  State<CustomSegmentedButton> createState() => _CustomSegmentedButtonState();
}

enum ProjectStatus { active, past }

class _CustomSegmentedButtonState extends State<CustomSegmentedButton> {
  ProjectStatus currentView = ProjectStatus.active;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ProjectStatus>(
      showSelectedIcon: false,
      segments: <ButtonSegment<ProjectStatus>>[
        ButtonSegment(
          value: ProjectStatus.active,
          label: Text('Active Projects',
              style: Theme.of(context).textTheme.titleMedium),
        ),
        ButtonSegment(
          value: ProjectStatus.past,
          label: Text('Past Projects',
              style: Theme.of(context).textTheme.titleMedium),
        ),
      ],
      selected: <ProjectStatus>{currentView},
      onSelectionChanged: (Set<ProjectStatus> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          //TODO: implement page content change
          currentView = newSelection.first;
        });
      },
    );
  }
}
