import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DepartamentInfoWidget extends StatelessWidget {
  const DepartamentInfoWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 90.w,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 6.w,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Icon(Icons.business,
                color: Theme.of(context).colorScheme.onPrimary),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
