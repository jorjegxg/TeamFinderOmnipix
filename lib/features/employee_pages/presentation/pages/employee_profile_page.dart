import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/snack_bar.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/logo_widget.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_managers/departments_managers_cubit.dart';
import 'package:team_finder_app/features/employee_pages/presentation/provider/edit_employee_provider.dart';
import 'package:team_finder_app/features/employee_pages/presentation/widgets/department_managers_dropdown.dart';
import 'package:team_finder_app/injection.dart';

class EmployeeProfilePage extends StatelessWidget {
  const EmployeeProfilePage({
    super.key,
    required this.userId,
    required this.employeeId,
    required this.employeeName,
    required this.employeeEmail,
    required this.isCurrentUser,
  });

  final String employeeId;
  final String employeeName;
  final String employeeEmail;
  final String userId;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EditEmployeeProvider>(
          create: (context) =>
              getIt<EditEmployeeProvider>()..getEmployeeData(employeeId),
        ),
        BlocProvider(
          create: (context) =>
              getIt<DepartmentsManagersCubit>()..getDepartmentManagers(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: !kIsWeb,
              centerTitle: true,
              title: Text(
                'Profile',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: Consumer<EditEmployeeProvider>(
              builder: (context, editEmployeeProvider, child) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
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
                          const SwitchesWidget(),
                          const SizedBox(height: 40),
                          BlocBuilder<DepartmentsManagersCubit,
                              DepartmentsManagersState>(
                            builder: (context, state) {
                              return CustomButton(
                                buttonHeight: 40,
                                text: 'Save changes',
                                onPressed: () async {
                                  final newManager = state.selectedManager;

                                  (await editEmployeeProvider.saveChanges(
                                    employeeId,
                                    isCurrentUser,
                                    newManager,
                                  ))
                                      .fold((l) {
                                    showSnackBar(context, l.message);
                                  }, (r) {
                                    showSnackBar(context, 'Changes saved');
                                  });
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ));
      }),
    );
  }
}

class SwitchesWidget extends StatelessWidget {
  const SwitchesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Organization admin',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Switch(
                      value: prov.isEmployeeOrganizationAdmin,
                      onChanged: (newVal) {
                        prov.changeOrganizationAdmin(newVal);
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Department manager',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Switch(
                      value: prov.isEmployeeDepartmentManager,
                      onChanged: (newVal) {
                        prov.changeDepartmentManager(newVal);
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (prov.departmentManagerHasToBeChanged)
                  BlocBuilder<DepartmentsManagersCubit,
                      DepartmentsManagersState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state.managers.isNotEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Select the new department manager:'),
                            const SizedBox(height: 7),
                            DepartmentManagersDropdown(
                              state: state,
                            ),
                          ],
                        );
                      }
                      return const Text(
                          'Create a new department manager first');
                    },
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Project manager',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Switch(
                      value: prov.isEmployeeProjectManager,
                      onChanged: (newVal) {
                        prov.changeProjectManager(newVal);
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ],
            );
          },
        ));
  }
}
