import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/departament_info_widget.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/option_widget.dart';

class DepartamentDetailsPage extends StatelessWidget {
  const DepartamentDetailsPage(
      {super.key, required this.departamentId, required this.userId});

  final String departamentId;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Departaments',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: const Column(
        children: [
          SizedBox(height: 20),
          Center(
              child: InfoWidget(
            text: 'Departament Name',
            icon: Icons.business,
          )),
          SizedBox(height: 20),
          DetailsBodyWidget()
        ],
      ),
    );
  }
}

class DetailsBodyWidget extends StatelessWidget {
  const DetailsBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Theme.of(context).colorScheme.onSurface,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              OptionWidget(
                text: 'View employees',
                onPressed: () {
                  context.goNamed(AppRouterConst.departamentEmployeesPage,
                      pathParameters: {
                        'userId': 'userId',
                        'departamentId': 'departamentId'
                      });
                },
              ),
              OptionWidget(
                text: 'View projects',
                onPressed: () {
                  context.goNamed(AppRouterConst.departamentProjectsPage,
                      pathParameters: {
                        'userId': 'userId',
                        'departamentId': 'departamentId'
                      });
                },
              ),
              OptionWidget(
                text: 'Confirmations',
                onPressed: () {
                  context.goNamed(AppRouterConst.confirmationsPage,
                      pathParameters: {
                        'userId': 'userId',
                        'departamentId': 'departamentId'
                      });
                },
              ),
              OptionWidget(
                text: 'Skill Validation',
                onPressed: () {
                  context.goNamed(AppRouterConst.skillValidationPage,
                      pathParameters: {
                        'userId': 'userId',
                        'departamentId': 'departamentId'
                      });
                },
              ),
              OptionWidget(
                text: 'Skill Statistics',
                onPressed: () {
                  context.goNamed(AppRouterConst.skillStatisticsPage,
                      pathParameters: {
                        'userId': 'userId',
                        'departamentId': 'departamentId'
                      });
                },
              ),
              OptionWidget(
                text: 'Departament Skills',
                onPressed: () {
                  context.goNamed(AppRouterConst.departamentSkillsPage,
                      pathParameters: {
                        'userId': 'userId',
                        'departamentId': 'departamentId'
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
