import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget(
      {super.key, required this.text, required this.icon, this.text2});
  final String text;
  final String? text2;
  final IconData icon;
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
            child: Icon(icon, color: Theme.of(context).colorScheme.onPrimary),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (text2 != null) ...[
                const SizedBox(height: 5),
                Text(
                  text2!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
