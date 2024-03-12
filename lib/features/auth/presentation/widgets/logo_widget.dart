import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
    required this.icon,
  });
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 115,
      child: Center(
        child: Container(
          width: 115,
          height: 115,
          decoration: ShapeDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: const OvalBorder(),
          ),
          child: Center(
            child: Icon(
              size: 80,
              color: Colors.white,
              icon,
            ),
          ),
        ),
      ),
    );
  }
}
