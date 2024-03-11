import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/change_page_widget.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/login_form.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/logo_widget.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/register_button.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({
    super.key,
    required this.isEmployee,
  });
  final bool isEmployee;
  @override
  Widget build(BuildContext context) {
    final emailConttroler = useTextEditingController(
      text: kDebugMode ? 'test@test.com' : '',
    );
    final passwordConttroler = useTextEditingController(
      text: kDebugMode ? 'parola' : '',
    );

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Success'),
            ),
          );
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Success'),
            ),
          );
        }
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
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: LogoWidget(),
                      ),
                      LoginForm(
                        emailConttroler: emailConttroler,
                        passwordConttroler: passwordConttroler,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomButton(
                              text: AuthConstants.login,
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                      LoginStarted(
                                        email: emailConttroler.text,
                                        password: passwordConttroler.text,
                                      ),
                                    );
                              },
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            ChangeAuthPageText(
                              text: AuthConstants.dontHaveAnAccount,
                              onPressed: () {
                                if (isEmployee) {
                                  context.goNamed(
                                      AppRouterConst.registerEmployeeName);
                                } else {
                                  context.goNamed(
                                      AppRouterConst.registerAdminName);
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
