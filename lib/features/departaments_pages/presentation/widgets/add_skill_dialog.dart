import 'package:flutter/material.dart';

class ChoiceDialog extends StatelessWidget {
  final VoidCallback chooseSkillPress;
  final VoidCallback createSkillPress;

  const ChoiceDialog({
    Key? key,
    required this.chooseSkillPress,
    required this.createSkillPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add skill to departament",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: chooseSkillPress,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                      radius: 20,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Text('A')),
                  const SizedBox(width: 20),
                  Text('Choose skill',
                      style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
            ),
            const Divider(),
            MaterialButton(
              onPressed: createSkillPress,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                      radius: 20,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Text('B')),
                  const SizedBox(width: 20),
                  Text('Create Skill',
                      style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
