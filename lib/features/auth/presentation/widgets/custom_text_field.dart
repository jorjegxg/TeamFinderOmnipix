import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.nameConttroler,
    this.hintText,
    this.isPassword = false,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.minLines = 1,
    this.width,
    this.onSubmitted,
    this.prefixIcon,
  });

  final TextEditingController nameConttroler;
  final String? hintText;
  final bool isPassword;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final int minLines;
  final double? width;
  final Function(String)? onSubmitted;
  final IconData? prefixIcon;
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
        textAlignVertical: prefixIcon != null ? TextAlignVertical.center : null,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: Theme.of(context).textTheme.bodyMedium,
        minLines: minLines,
        maxLines: minLines,
        keyboardType: TextInputType.text,
        obscureText: isPassword,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.labelSmall,
            contentPadding: const EdgeInsetsDirectional.only(start: 20)),
        controller: nameConttroler,
      ),
    );
  }
}
