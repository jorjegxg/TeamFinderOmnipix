import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_text_field.dart';

class LoginForm extends HookWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final emailConttroler = useTextEditingController();
    final passwordConttroler = useTextEditingController();

    return Center(
      child: Container(
        width: getValueForScreenType(
            context: context, mobile: 70.w, tablet: 60.w, desktop: 35.w),
        height:
            getValueForScreenType(context: context, mobile: 200, desktop: 250),
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              blurRadius: 4,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomTextField(
              nameConttroler: emailConttroler,
              hintText: AuthConstants.email,
              onSubmitted: (String) {},
            ),
            CustomTextField(
              nameConttroler: passwordConttroler,
              hintText: AuthConstants.password,
              onSubmitted: (String) {},
              isPassword: true,
            ),
          ],
        ),
      ),
    );
  }
}
