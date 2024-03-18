import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/core/util/functions.dart';
import 'package:team_finder_app/core/util/snack_bar.dart';
import 'package:team_finder_app/features/auth/domain/auth_usecase.dart';
import 'package:team_finder_app/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:team_finder_app/features/auth/presentation/widgets/change_page_widget.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/get_details_form.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/logo_widget.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:team_finder_app/injection.dart';

class RegisterScreen extends HookWidget {
  const RegisterScreen({
    super.key,
    required this.isEmployee,
    this.organizationId,
  });
  final bool isEmployee;
  final String? organizationId;
  //daca isEmployee e true => organizationId != null
  @override
  Widget build(BuildContext context) {
    final nameConttroler = useTextEditingController(
      text: kDebugMode ? 'Nume test ${generateRandomString(3)}' : '',
    );
    final emailConttroler = useTextEditingController(
      text: kDebugMode
          ? '${generateRandomString(5)}@${generateRandomString(5)}.${generateRandomString(5)}'
          : '',
    );
    final passwordConttroler = useTextEditingController(
      text: kDebugMode ? 'parola' : '',
    );
    final organizationNameConttroler = useTextEditingController(
      text: kDebugMode ? 'Nume organizatie ${generateRandomString(5)}' : '',
    );
    final organizationAddressConttroler = useTextEditingController(
      text: kDebugMode ? 'Adresa organizatie ${generateRandomString(5)}' : '',
    );
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.goNamed(
            AppRouterConst.projectsMainScreen,
            pathParameters: {'userId': state.userId},
          );
        }

        if (state is AuthError) {
          showSnackBar(context, state.message);
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: LogoWidget(
                          icon: Icons.handshake,
                        ),
                      ),
                      if (isEmployee)
                        FutureBuilder(
                            future: getIt<AuthUsecase>().getOrganizationName(
                                organizationId: organizationId!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text(
                                  snapshot.error.toString(),
                                  style: Theme.of(context).textTheme.titleLarge,
                                );
                              }

                              return Text(
                                (snapshot.data)!.fold(
                                  (l) => 'Error',
                                  (r) => r,
                                ),
                                style: Theme.of(context).textTheme.titleLarge,
                              );
                            }),
                      GetDetailsForm(
                        isEmployee: isEmployee,
                        nameConttroler: nameConttroler,
                        emailConttroler: emailConttroler,
                        passwordConttroler: passwordConttroler,
                        organizationNameConttroler: organizationNameConttroler,
                        organizationAddressConttroler:
                            organizationAddressConttroler,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return CustomButton(
                                  text: AuthConstants.register,
                                  isLoading: state is AuthLoading,
                                  onPressed: () {
                                    context.read<AuthBloc>().add(
                                          isEmployee
                                              ? RegisterEmployeeStarted(
                                                  name: nameConttroler.text,
                                                  email: emailConttroler.text,
                                                  password:
                                                      passwordConttroler.text,
                                                  organizationId:
                                                      organizationId!,
                                                )
                                              : RegisterOrganizationAdminStarted(
                                                  name: nameConttroler.text,
                                                  email: emailConttroler.text,
                                                  password:
                                                      passwordConttroler.text,
                                                  organizationName:
                                                      organizationNameConttroler
                                                          .text,
                                                  organizationAddress:
                                                      organizationAddressConttroler
                                                          .text,
                                                ),
                                        );
                                  },
                                );
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
