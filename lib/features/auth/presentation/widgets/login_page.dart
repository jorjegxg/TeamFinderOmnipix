import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/change_page_widget.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/login_form.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/logo_widget.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/register_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
    required this.isEmployee,
  });
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
                const LoginForm(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RegisterButton(
                      text: AuthConstants.login,
                      onPressed: () {
                        //TODO: implement login user
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    ChangeAuthPageText(
                      text: AuthConstants.dontHaveAnAccount,
                      onPressed: () {
                        if (isEmployee) {
                          context.goNamed(AppRouterConst.registerEmployeeName);
                        } else {
                          context.goNamed(AppRouterConst.registerAdminName);
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
