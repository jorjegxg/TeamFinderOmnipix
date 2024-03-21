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
    this.isLoading = false,
    this.color,
  });
  final String text;
  final Function() onPressed;
  final double buttonHeight;
  final double? buttonWidth;
  final bool isLoading;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: buttonHeight,
      minWidth: buttonWidth ??
          getValueForScreenType(
            context: context,
            mobile: MediaQuery.of(context).size.width / 2,
            tablet: MediaQuery.of(context).size.width / 4,
            desktop: MediaQuery.of(context).size.width / 8,
          ),
      color: color ?? Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      onPressed: isLoading ? () {} : onPressed,
      child: isLoading
          ? CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onPrimary,
            )
          : Text(
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
