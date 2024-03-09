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
        height: isEmployee ? 35.h : 50.h,
        decoration: ShapeDecoration(
          color: AppLightColors.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: const [
            BoxShadow(
              color: AppLightColors.shadow,
              blurRadius: 4,
              offset: Offset(0, 4),
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
            ),
            CustomTextField(
              nameConttroler: emailConttroler,
              hintText: AuthConstants.email,
            ),
            CustomTextField(
              nameConttroler: passwordConttroler,
              hintText: AuthConstants.password,
              isPassword: true,
            ),
            if (!isEmployee)
              CustomTextField(
                nameConttroler: organizationNameConttroler,
                hintText: AuthConstants.organizationName,
              ),
            if (!isEmployee)
              CustomTextField(
                nameConttroler: organizationAddressConttroler,
                hintText: AuthConstants.organizationAddress,
              ),
          ],
        ),
      ),
    );
  }
}
