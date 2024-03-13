import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/features/auth/data/models/manager.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_managers/departments_managers_cubit.dart';
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
      child: Builder(builder: (context) {
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
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 15),
                Text(
                  'This link shall be used to add new employees to the app',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  nameConttroler: nameConttroler,
                  onSubmitted: (value) {
                    //TODO George Luta : add functionality to the onSubmitted
                  },
                  width: 100.w,
                  hintText: 'Departament Name',
                ),
                const SizedBox(height: 15),
                const Text('Department Manager:'),
                const SizedBox(height: 7),
                BlocBuilder<DepartmentsManagersCubit, DepartmentsManagersState>(
                  builder: (context, state) {
                    if (state is DepartmentsManagersLoading ||
                        state is DepartmentsManagersInitial) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is DepartmentsManagersLoaded) {
                      return DropdownButtonFormField<Manager>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        //TODO George Luta : schimba
                        value: null,
                        elevation: 16,
                        style: Theme.of(context).textTheme.bodyMedium,
                        borderRadius: BorderRadius.circular(12),
                        onChanged: (Manager? newValue) {
                          //TODO George Luta : add functionality to the onChanged
                        },
                        items: state.managers
                            .map<DropdownMenuItem<Manager>>((Manager value) {
                          return DropdownMenuItem<Manager>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                      );
                    }

                    if (state is DepartmentsManagersError) {
                      return Text(state.errorMessage!);
                    }

                    return const SizedBox();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close'),
                    ),
                    TextButton(
                      onPressed: () {
                        //TODO: add functionality to the add button to copy the link
                        Navigator.pop(context);
                      },
                      child: const Text('Create'),
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
