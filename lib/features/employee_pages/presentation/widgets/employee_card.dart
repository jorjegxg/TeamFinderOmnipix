import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    super.key,
    required this.name,
    required this.onTap,
    this.isCurrentUser = false,
  });
  final String name;
  final Function() onTap;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 100.w,
        height: 10.h,
        child: Card(
          color: isCurrentUser ? Theme.of(context).colorScheme.primary : null,
          child: Row(
            children: [
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 20,
                backgroundColor: isCurrentUser
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.primary,
                child: Icon(
                  Icons.person,
                  color: isCurrentUser
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onPrimary,
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
      ),
    );
  }
}
