import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_create/department_create_cubit.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_get/departments_get_cubit.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_managers/departments_managers_cubit.dart';
import 'package:team_finder_app/features/employee_pages/presentation/widgets/department_managers_dropdown.dart';
import 'package:team_finder_app/injection.dart';

class CreateDepartamentDialog extends HookWidget {
  const CreateDepartamentDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameConttroler = useTextEditingController();
    return BlocProvider(
      create: (context) =>
          getIt<DepartmentsManagersCubit>()..getDepartmentManagers(),
      child: Builder(builder: (secondContext) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Create Departament',
                  style: Theme.of(secondContext).textTheme.titleSmall,
                ),
                const SizedBox(height: 15),
                Text(
                  'This link shall be used to add new employees to the app',
                  style: Theme.of(secondContext).textTheme.bodyMedium,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  nameConttroler: nameConttroler,
                  width: 100.w,
                  hintText: 'Departament Name',
                ),
                const SizedBox(height: 15),
                BlocBuilder<DepartmentsManagersCubit, DepartmentsManagersState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.managers.isNotEmpty) {
                      return Column(
                        children: [
                          const Text('Department Manager:'),
                          const SizedBox(height: 7),
                          DepartmentManagersDropdown(
                            state: state,
                          ),
                        ],
                      );
                    }

                    return const Text('Create a new department manager first');
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(secondContext);
                      },
                      child: const Text('Close'),
                    ),
                    BlocConsumer<DepartmentsManagersCubit,
                        DepartmentsManagersState>(
                      listener: (context, state) {
                        if (state is DepartmentsCreateSuccess) {
                          Navigator.pop(secondContext);
                        }
                      },
                      builder: (context, state) {
                        return TextButton(
                          onPressed: () {
                            secondContext
                                .read<DepartmentCreateCubit>()
                                .createDepartment(
                                  name: nameConttroler.text,
                                  manager: state.selectedManager,
                                );

                            context
                                .read<DepartmentsGetCubit>()
                                .getDepartmentsFromOrganization(true);

                            Navigator.pop(secondContext);
                          },
                          child: const Text('Create'),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
