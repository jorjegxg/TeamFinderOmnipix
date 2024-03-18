import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';

class ProjectMemberCard extends StatelessWidget {
  const ProjectMemberCard({
    super.key,
    required this.name,
    required this.email,
    required this.onPressed,
  });

  final String name;
  final String email;
  final Function(BuildContext) onPressed;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      endActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dragDismissible: false,
        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            backgroundColor: const Color(0xFFDCBABA),
            foregroundColor: Colors.white,
            icon: Icons.person_remove,
            label: 'Remove',
            onPressed: onPressed,
          ),
        ],
      ),
      child: Container(
        width: 100.w,
        height: 10.h,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              blurRadius: 4,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 20,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).textTheme.titleSmall),
                Text(email, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
