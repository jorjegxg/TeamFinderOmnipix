import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({super.key, required this.text, required this.onPressed});
  final String text;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(
                Icons.insert_drive_file,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 40),
              Text(
                text,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Expanded(child: Container()),
              const Icon(
                Icons.arrow_forward_ios,
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
