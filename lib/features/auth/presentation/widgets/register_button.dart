import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.buttonHeight = 50,
    this.buttonWidth,
  });
  final String text;
  final Function() onPressed;
  final double buttonHeight;
  final double? buttonWidth;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: buttonHeight,
      minWidth: buttonWidth ??
          getValueForScreenType(
              context: context, mobile: 50.w, tablet: 30.w, desktop: 10.w),
      color: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          height: 0,
        ),
      ),
    );
  }
}
