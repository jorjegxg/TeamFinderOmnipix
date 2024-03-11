import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:team_finder_app/features/auth/presentation/widgets/change_page_widget.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/get_details_form.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/logo_widget.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/register_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key, required this.isEmployee});
  final bool isEmployee;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // if (state is AuthSuccess) {
        //   context.goNamed(AppRouterConst.homeName);
        // }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Sizer(
            builder: (BuildContext context, Orientation orientation,
                DeviceType deviceType) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 100.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: LogoWidget(),
                      ),
                      GetDetailsForm(
                        isEmployee: isEmployee,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomButton(
                              text: AuthConstants.register,
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                      // isEmployee
                                      //     ? const RegisterEmployeeStarted(
                                      //         name: 'name',
                                      //         email: 'email',
                                      //         password: 'password',
                                      //       )
                                      //     :
                                      const RegisterOrganizationAdminStarted(
                                        name: 'name',
                                        email:
                                            'emailsfrhfhdsfrgdrfg@sergrsg.sgrgsrgr',
                                        password: 'password',
                                        organizationName: 'organizationName',
                                        organizationAddress:
                                            'organizationAddress',
                                      ),
                                    );
                              },
                            ),
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                if (state is AuthLoading) {
                                  return const CircularProgressIndicator();
                                }
                                return Container();
                              },
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            ChangeAuthPageText(
                              text: AuthConstants.alreadyHaveAnAccount,
                              onPressed: () {
                                if (isEmployee) {
                                  context.goNamed(
                                      AppRouterConst.loginEmployeeName);
                                } else {
                                  context
                                      .goNamed(AppRouterConst.loginAdminName);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
