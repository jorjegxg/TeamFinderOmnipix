import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SkillCard extends StatelessWidget {
  final String skillName;
  final String skillDescription;
  final String skillAuthor;
  final Function(BuildContext) onPressed;
  const SkillCard({
    super.key,
    required this.skillName,
    required this.skillDescription,
    required this.skillAuthor,
    required this.onPressed,
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
            onPressed: onPressed,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {},
        child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/carnetel.png',
                ),
                Center(
                  child: Text(
                    skillName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  skillDescription,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  skillAuthor,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
