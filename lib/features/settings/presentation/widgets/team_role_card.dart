import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TeamRoleCard extends StatelessWidget {
  final String role;
  final Function(BuildContext) onDelete;
  final Function(BuildContext) onEdit;
  const TeamRoleCard(
      {super.key,
      required this.role,
      required this.onDelete,
      required this.onEdit});

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
            backgroundColor: Color(0xFFDCBABA),
            foregroundColor: Colors.white,
            icon: Icons.person_remove,
            label: 'Remove',
            onPressed: onEdit,
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
            backgroundColor: Color.fromARGB(255, 170, 240, 161),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
            onPressed: onDelete,
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              role,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}