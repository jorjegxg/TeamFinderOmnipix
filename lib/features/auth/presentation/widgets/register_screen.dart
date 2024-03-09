import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/constants.dart';

import 'package:team_finder_app/features/auth/presentation/widgets/change_page_widget.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/get_details_form.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/logo_widget.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/register_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key, required this.isEmployee});
  final bool isEmployee;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppLightColors.surface,
        body: Sizer(
          builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const LogoWidget(),
                GetDetailsForm(
                  isEmployee: isEmployee,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RegisterButton(
                      text: AuthConstants.register,
                      onPressed: () {
                        //TODO: implement register administrator
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    ChangeAuthPageText(
                      text: AuthConstants.alreadyHaveAnAccount,
                      onPressed: () {
                        if (isEmployee) {
                          context.goNamed(AppRouterConst.loginEmployeeName);
                        } else {
                          context.goNamed(AppRouterConst.loginAdminName);
                        }
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
