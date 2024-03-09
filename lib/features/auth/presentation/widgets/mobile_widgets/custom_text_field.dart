import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/util/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.nameConttroler, required this.hintText,this.isPassword=false
  });

  final TextEditingController nameConttroler;
  final String hintText;
  final bool isPassword;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
          width: getValueForScreenType(context: context, mobile: 65.w, tablet: 55.w, desktop: 30.w),
          height: 6.h,
           decoration: BoxDecoration(
          color: AppLightColors.textField,
          borderRadius:  BorderRadius.circular(15),
        ),
          child: TextField(
            obscureText: isPassword,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              border:InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppLightColors.hintTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 0,
                ),
               contentPadding:const EdgeInsetsDirectional.only(start: 20)
               ),
            controller: nameConttroler,
          ),
        );
  }
}


