import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/snack_bar.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/delete_department_provider.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_create/department_create_cubit.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_get/departments_get_cubit.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/create_departament_dialog.dart';
import 'package:team_finder_app/features/employee_pages/presentation/provider/employee_roles_provider.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/project_widget.dart';
import 'package:team_finder_app/injection.dart';

class DepartamentMainPage extends StatefulWidget {
  const DepartamentMainPage({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  State<DepartamentMainPage> createState() => _DepartamentMainPageState();
}

class _DepartamentMainPageState extends State<DepartamentMainPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<DepartmentsGetCubit>().getDepartmentsFromOrganization();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<DepartmentsGetCubit>().getDepartmentsFromOrganization();
      },
      child: Builder(builder: (context) {
        return BlocListener<DepartmentCreateCubit, DepartmentsState>(
          listener: (context, state) {
            if (state is DepartmentsCreateSuccess) {
              showSnackBar(context, 'Departament created successfully');
            }

            if (state is DepartmentsCreateFailure) {
              showSnackBar(context, state.errorMessage);
            }
          },
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add, color: Colors.black),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => const CreateDepartamentDialog());
              },
            ),
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Departaments',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: ListOfDepartments(widget: widget),
          ),
        );
      }),
    );
  }
}

class ListOfDepartments extends StatelessWidget {
  const ListOfDepartments({
    super.key,
    required this.widget,
  });

  final DepartamentMainPage widget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DepartmentsGetCubit, DepartmentsGetState>(
      builder: (context, state) {
        if (state is DepartmentsGetManagersLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DepartmentsGetManagersFailure) {
          return Center(
            child: Text(state.errorMessage),
          );
        }

        if (state is DepartmentsGetManagersSuccess) {
          if (state.departments.isNotEmpty) {
            return ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                itemCount: state.departments.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        GestureDetector(child: Consumer<EmployeeRolesProvider>(
                      builder: (context, prov, child) {
                        return Consumer<DeleteDepartmentProvider>(
                          builder: (context, deleteDepartmentProvider, child) {
                            return ProjectWidget(
                                isLoading: deleteDepartmentProvider.isLoading,
                                showDetailsButton: prov.isDepartmentManager,
                                onLongPress: () {
                                  if (prov.isOrganizationAdmin) {
                                    //alert dialog with delete option:
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text('Delete Departament',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary)),
                                              content: const Text(
                                                  'Are you sure you want to delete this departament?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      getIt<DeleteDepartmentProvider>()
                                                          .deleteDepartment(
                                                              state
                                                                  .departments[
                                                                      index]
                                                                  .id);

                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Yes')),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('No')),
                                              ],
                                            ));
                                  }
                                },
                                mainTitle:
                                    state.departments[index].departmentName,
                                title1: 'Departament Manager:',
                                title2: 'Number of employees:',
                                content1:
                                    state.departments[index].managersName ??
                                        'No manager',
                                content2: state
                                    .departments[index].numberOfEmployees
                                    .toString(),
                                onPressed: () {
                                  context.goNamed(
                                      AppRouterConst.departamentsDetailsPage,
                                      pathParameters: {
                                        'userId': widget.userId,
                                        'departamentId':
                                            state.departments[index].id
                                      });
                                });
                          },
                        );
                      },
                    )),
                  );
                });
          } else {
            return const Center(child: Text('No departaments found <3'));
          }
        }

        return const SizedBox();
      },
    );
  }
}
