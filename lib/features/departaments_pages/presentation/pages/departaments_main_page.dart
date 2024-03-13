import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/snack_bar.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments/departments_cubit.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/create_departament_dialog.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/project_widget.dart';

class DepartamentMainPage extends StatelessWidget {
  const DepartamentMainPage({
    super.key,
    required this.userId,
  });

  final String userId;
  @override
  Widget build(BuildContext context) {
    return BlocListener<DepartmentsCubit, DepartmentsState>(
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
            //TODO: get list of free managers
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
        body: ListView.builder(
            // physics: const NeverScrollableScrollPhysics(),
            // shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: ProjectWidget(
                      onLongPress: () {
                        print('asdasd');
                      },
                      mainTitle: 'Departament Name',
                      title1: 'Departament Manager:',
                      title2: 'Number of employees:',
                      content1: 'Name of the manager',
                      content2: 'Number of employees in the departament',
                      onPressed: () {
                        context.goNamed(AppRouterConst.departamentsDetailsPage,
                            pathParameters: {
                              'userId': userId,
                              'departamentId': 'departamentId'
                            });
                        //TODO: navigate to departament details, pass departament id
                      }),
                ),
              );
            }),
      ),
    );
  }
}
