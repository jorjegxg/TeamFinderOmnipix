import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';

class ProjectWidget extends StatelessWidget {
  const ProjectWidget({
    super.key,
    required this.mainTitle,
    required this.title1,
    required this.title2,
    required this.content1,
    required this.content2,
    required this.onPressed,
    this.onLongPress,
    this.color,
    this.buttonText,
    this.isLoading = false,
  });

  final String mainTitle;
  final String title1;
  final String title2;
  final String content1;
  final String content2;
  final Function() onPressed;
  final Function()? onLongPress;
  final Color? color;
  final String? buttonText;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFCAC4D0)),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          height: getValueForScreenType(
              context: context, mobile: 250, desktop: 200, tablet: 200),
          width: getValueForScreenType(
              context: context, mobile: 100, desktop: 200, tablet: 200),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(mainTitle,
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                const SizedBox(height: 10),
                const Divider(),
                Text(
                  title1,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  content1,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  title2,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  content2,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomButton(
                    text: buttonText ?? 'View Details',
                    onPressed: onPressed,
                    buttonHeight: 30,
                    buttonWidth: 60,
                    color: color,
                    isLoading: isLoading,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
