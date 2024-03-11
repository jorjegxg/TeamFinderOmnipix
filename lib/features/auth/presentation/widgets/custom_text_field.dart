import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.nameConttroler,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.minLines = 1,
    this.width,
    required this.onSubmitted,
  });

  final TextEditingController nameConttroler;
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final int minLines;
  final double? width;
  final Function(String) onSubmitted;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width ??
          getValueForScreenType(
              context: context, mobile: 65.w, tablet: 55.w, desktop: 30.w),
      // height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onSubmitted: onSubmitted,
        style: Theme.of(context).textTheme.bodyMedium,
        minLines: minLines,
        maxLines: minLines,
        keyboardType: TextInputType.text,
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
