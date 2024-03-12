import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.iconColor,
  });
  final IconData icon;
  final Function() onPressed;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
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
        child: IconButton(
          color: iconColor,
          onPressed: onPressed,
          icon: Icon(icon),
        ));
  }
}
