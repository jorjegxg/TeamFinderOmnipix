import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
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
      width: getValueForScreenType(
          context: context,
          mobile: MediaQuery.of(context).size.width * 0.9,
          tablet: MediaQuery.of(context).size.width * 0.9,
          desktop: MediaQuery.of(context).size.width * 0.9),
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
            radius: getValueForScreenType(
                context: context,
                mobile: MediaQuery.of(context).size.width * 0.08,
                tablet: MediaQuery.of(context).size.width * 0.02,
                desktop: MediaQuery.of(context).size.width * 0.02),
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
