import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NewMembersCard extends StatelessWidget {
  const NewMembersCard(
      {super.key,
      required this.name,
      required this.email,
      required this.onDoubleTap,
      this.color});
  final String name;
  final String email;
  final Function() onDoubleTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: Container(
        width: 100.w,
        height: 80,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.surfaceContainer,
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
