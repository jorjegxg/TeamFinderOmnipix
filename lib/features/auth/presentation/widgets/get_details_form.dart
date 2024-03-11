import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_text_field.dart';

class GetDetailsForm extends HookWidget {
  const GetDetailsForm({
    super.key,
    required this.isEmployee,
  });
  final bool isEmployee;
  @override
  Widget build(BuildContext context) {
    final nameConttroler = useTextEditingController();
    final emailConttroler = useTextEditingController();
    final passwordConttroler = useTextEditingController();
    final organizationNameConttroler = useTextEditingController();
    final organizationAddressConttroler = useTextEditingController();
    return Center(
      child: Container(
        width: getValueForScreenType(
            context: context, mobile: 70.w, tablet: 60.w, desktop: 35.w),
        height: isEmployee
            ? getValueForScreenType(
                context: context, mobile: 200, tablet: 350, desktop: 350)
            : getValueForScreenType(
                context: context, mobile: 400, tablet: 500, desktop: 500),
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
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
              nameConttroler: nameConttroler,
              hintText: AuthConstants.name,
              onSubmitted: (String) {},
            ),
            CustomTextField(
              nameConttroler: emailConttroler,
              hintText: AuthConstants.email,
              onSubmitted: (String) {},
            ),
            CustomTextField(
              nameConttroler: passwordConttroler,
              hintText: AuthConstants.password,
              isPassword: true,
              onSubmitted: (String) {},
            ),
            if (!isEmployee)
              CustomTextField(
                nameConttroler: organizationNameConttroler,
                hintText: AuthConstants.organizationName,
                onSubmitted: (String) {},
              ),
            if (!isEmployee)
              CustomTextField(
                nameConttroler: organizationAddressConttroler,
                hintText: AuthConstants.organizationAddress,
                onSubmitted: (String) {},
              ),
          ],
        ),
      ),
    );
  }
}
