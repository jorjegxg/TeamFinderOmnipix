import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/add_employee_departament_provider.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/item_with_checkbox.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/search_text_field.dart';
import 'package:team_finder_app/injection.dart';

class AddEmployeeToDepartamentPage extends HookWidget {
  const AddEmployeeToDepartamentPage({
    super.key,
    required this.userId,
    required this.departamentId,
  });
  final String userId;
  final String departamentId;

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameConttroler = TextEditingController();
    return ChangeNotifierProvider(
      create: (context) => getIt<AddEmployeeToDepartamentProvider>()
        ..fetchEmployeesForDepartments(),
      child: Builder(builder: (context) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Add Employees',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: Sizer(
              builder: (BuildContext context, Orientation orientation,
                  DeviceType deviceType) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Consumer<AddEmployeeToDepartamentProvider>(
                        builder: (context, provider, child) {
                      return provider.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : provider.employees.isEmpty
                              ? Text(
                                  'No employees found',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 20),
                                    SearchTextField(
                                      nameConttroler: nameConttroler,
                                      onSubmitted: (String s) {},
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            const Divider(),
                                        itemCount: provider.employees.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: ItemWithCheckBox(
                                              enabled: true,
                                              value: provider.checkedEmployees
                                                  .contains(provider
                                                      .employees[index]),
                                              text: provider
                                                  .employees[index].name,
                                              onChanged: (bool? b, int number) {
                                                if (b!) {
                                                  provider.addEmployee(provider
                                                      .employees[index]);
                                                } else {
                                                  provider.removeEmployee(
                                                      provider
                                                          .employees[index]);
                                                }
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 60),
                                    CustomButton(
                                      text: "Add",
                                      onPressed: () async {
                                        await provider.addEmployeesToDepartment(
                                            departamentId);
                                        context.goNamed(
                                            AppRouterConst
                                                .departamentEmployeesPage,
                                            pathParameters: {
                                              'userId': userId,
                                              'departamentId': departamentId
                                            });
                                      },
                                    ),
                                  ],
                                );
                    }),
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
