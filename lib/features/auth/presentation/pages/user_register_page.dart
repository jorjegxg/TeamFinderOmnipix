import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/util/constants.dart';

import 'package:team_finder_app/features/auth/presentation/widgets/mobile_widgets/change_page_widget.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/mobile_widgets/get_details_form.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/mobile_widgets/logo_widget.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/mobile_widgets/register_button.dart';
class RegisterScreenForAdmin extends StatelessWidget {
  const RegisterScreenForAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppLightColors.surface,
        body: Sizer(
          builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) {
            return const RegisterPage();
          },
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const LogoWidget(),
        const GetDetailsForm(),
        RegisterButton(text: AuthConstants.register,onPressed: () {
          //TODO: implement register administrator
        },
        ),
        const ChangeAuthPageText(),
      ],
    );
  }
}