import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    super.key,
    required this.name,
    required this.onTap,
  });
  final String name;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
