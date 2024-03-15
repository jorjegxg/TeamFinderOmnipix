import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departament_employees_provider.dart';
import 'package:team_finder_app/features/employee_pages/presentation/widgets/employee_card.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/search_text_field.dart';
import 'package:team_finder_app/injection.dart';

class DepartamentEmployeesPage extends HookWidget {
  const DepartamentEmployeesPage({
    super.key,
    required this.userId,
    required this.departamentId,
  });
  final String userId;
  final String departamentId;

  @override
  Widget build(BuildContext context) {
    List<String> items = List.generate(10, (index) => 'Item $index');
    final TextEditingController nameConttroler = useTextEditingController();
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => getIt<DepartamentEmployeesProvider>()
          ..fetchEmployeesForDepartments(departamentId),
        child: Builder(builder: (context) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add, color: Colors.black),
              onPressed: () {
                context.goNamed(
                  AppRouterConst.addEmployeeToDepartament,
                  pathParameters: {
                    'userId': userId,
                    'departamentId': departamentId,
                  },
                );
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
                        Expanded(
                          child: Consumer<DepartamentEmployeesProvider>(
                            builder: (context, provider, state) {
                              return ListView.builder(
                                itemCount: provider.employees.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: EmployeeCard(
                                      name: provider.employees[index].name,
                                      onTap: () {
                                        //TODO: implement onTap
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
