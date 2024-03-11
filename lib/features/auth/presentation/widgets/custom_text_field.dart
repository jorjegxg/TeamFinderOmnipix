import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.nameConttroler,
    required this.hintText,
    this.isPassword = false,
    this.onChanged,
  });

  final TextEditingController nameConttroler;
  final String hintText;
  final bool isPassword;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: getValueForScreenType(
          context: context, mobile: 65.w, tablet: 55.w, desktop: 30.w),
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: onChanged,
        obscureText: isPassword,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.labelSmall,
            contentPadding: const EdgeInsetsDirectional.only(start: 20)),
        controller: nameConttroler,
      ),
    );
  }
}
