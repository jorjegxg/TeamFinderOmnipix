import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/logo_widget.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';
import 'package:team_finder_app/features/employee_pages/presentation/provider/edit_employee_provider.dart';
import 'package:team_finder_app/injection.dart';

class EmployeeProfilePage extends StatelessWidget {
  const EmployeeProfilePage({
    super.key,
    required this.userId,
    required this.employeeId,
    required this.employeeName,
    required this.employeeEmail,
  });

  final String employeeId;
  final String employeeName;
  final String employeeEmail;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EditEmployeeProvider>(
          create: (context) =>
              getIt<EditEmployeeProvider>()..getEmployeeRoles(employeeId),
        )
      ],
      child: Builder(builder: (context) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => context.goNamed(
                    AppRouterConst.employeesMainScreen,
                    pathParameters: {'userId': userId}),
              ),
              centerTitle: true,
              title: Text(
                'Profile',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: Consumer<EditEmployeeProvider>(
              builder: (context, editEmployeeProvider, child) {
                return Column(
                  children: [
                    const SizedBox(height: 40),
                    const Center(
                      child: LogoWidget(
                        icon: Icons.person,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      employeeName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      employeeEmail,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 40),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Consumer<EditEmployeeProvider>(
                          builder: (context, prov, child) {
                            if (prov.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Organization admin',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    //provider for one value

                                    Switch(
                                        value: prov.isEmployeeOrganizationAdmin,
                                        onChanged: (newVal) {},
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Department manager',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Switch(
                                        value: prov.isEmployeeDepartmentManager,
                                        onChanged: (newVal) {},
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Project manager',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Switch(
                                        value: prov.isEmployeeProjectManager,
                                        onChanged: (newVal) {},
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ],
                                ),
                              ],
                            );
                          },
                        )),
                    Expanded(child: Container()),
                    CustomButton(
                      buttonHeight: 40,
                      text: 'Save changes',
                      onPressed: () {
                        //TODO: implement save changes
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ));
      }),
    );
  }
}
