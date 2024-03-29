import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TeamRoleCard extends StatelessWidget {
  final String role;
  final Function(BuildContext) onDelete;
  final Function(BuildContext) onEdit;

  const TeamRoleCard({
    super.key,
    required this.role,
    required this.onDelete,
    required this.onEdit,
  });

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
            onPressed: onDelete,
            borderRadius: BorderRadius.circular(8.0),
            padding: const EdgeInsets.all(16.0),
          ),
        ],
      ),
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dragDismissible: false,
        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            backgroundColor: Color.fromARGB(255, 155, 233, 153),
            foregroundColor: Colors.white,
            icon: Icons.person_remove,
            label: 'Edit',
            onPressed: onEdit,
            borderRadius: BorderRadius.circular(8.0),
            padding: const EdgeInsets.all(16.0),
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              role,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
