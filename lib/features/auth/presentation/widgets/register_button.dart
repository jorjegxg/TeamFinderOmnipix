import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/util/constants.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    required this.text,
    required this.onPressed,
    super.key,
  });
  final String text;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 6.h,
      minWidth: getValueForScreenType(context: context, mobile: 50.w, tablet: 30.w, desktop: 10.w),
      color: AppLightColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      onPressed: onPressed,
      child:  Text(
        text,
        style: const TextStyle(
          color: AppLightColors.white,
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          height: 0,
        ),
      ),
    );
  }
}
