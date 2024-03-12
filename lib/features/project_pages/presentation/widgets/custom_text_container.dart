import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';

class CustomTextContainer extends StatelessWidget {
  const CustomTextContainer({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return Container(
          alignment: Alignment.centerLeft,
          width: getValueForScreenType(
              context: context, mobile: 100.w, tablet: 55.w, desktop: 30.w),
          //height: getValueForScreenType(context: context, mobile: 40),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        );
      },
    );
  }
}
