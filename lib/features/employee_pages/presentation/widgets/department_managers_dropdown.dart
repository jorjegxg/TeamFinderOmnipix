import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:team_finder_app/features/auth/data/models/manager.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_managers/departments_managers_cubit.dart';

class DepartmentManagersDropdown extends StatelessWidget {
  const DepartmentManagersDropdown({
    super.key,
    required this.state,
  });

  final DepartmentsManagersState state;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Manager>(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      value: state.selectedManager,
      elevation: 16,
      style: Theme.of(context).textTheme.bodyMedium,
      borderRadius: BorderRadius.circular(12),
      onChanged: (Manager? newValue) {
        context.read<DepartmentsManagersCubit>().selectManager(newValue!);
      },
      items: state.managers.map<DropdownMenuItem<Manager>>((Manager value) {
        return DropdownMenuItem<Manager>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }
}
