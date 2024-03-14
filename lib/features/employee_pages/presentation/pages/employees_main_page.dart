import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/employee_pages/presentation/provider/employee_provider.dart';
import 'package:team_finder_app/features/employee_pages/presentation/widgets/copy_link_dialog.dart';

import 'package:team_finder_app/features/employee_pages/presentation/widgets/employee_card.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/search_text_field.dart';
import 'package:team_finder_app/injection.dart';

class EmployeeMainPage extends HookWidget {
  const EmployeeMainPage({
    super.key,
    required this.userId,
  });
  final String userId;

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameConttroler = TextEditingController();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EmployeeProvider>(
          create: (context) => getIt<EmployeeProvider>()..fetchEmployees(),
        )
      ],
      child: Builder(builder: (context) {
        return SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add, color: Colors.black),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return const CopyLinkDialog();
                    });
              },
            ),
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Employees',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: Sizer(
              builder: (BuildContext context, Orientation orientation,
                  DeviceType deviceType) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        SearchTextField(
                          nameConttroler: nameConttroler,
                          onSubmitted: (String s) {},
                        ),
                        const SizedBox(height: 10),
                        Expanded(child: Consumer<EmployeeProvider>(
                          builder: (context, employeeProvider, child) {
                            if (employeeProvider.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (employeeProvider.error != null) {
                              return Center(
                                child: Text(employeeProvider.error!),
                              );
                            } else {
                              return ListView.builder(
                                itemCount: employeeProvider.employees.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: EmployeeCard(
                                      name: employeeProvider
                                          .employees[index].name,
                                      onTap: () {
                                        context.goNamed(
                                          AppRouterConst.employeeProfileScreen,
                                          pathParameters: {
                                            'employeeId': 'employeeId',
                                            'userId': userId,
                                          },
                                        );
                                        //TODO: implement onTap
                                      },
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        )),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
