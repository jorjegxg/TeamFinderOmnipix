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
              child: DepartamentInfoWidget(
            text: 'Departament Name',
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
              SizedBox(height: 40),
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
                onPressed: () {},
              ),
              OptionWidget(
                text: 'Confirmations',
                onPressed: () {},
              ),
              OptionWidget(
                text: 'Skill Validation',
                onPressed: () {},
              ),
              OptionWidget(
                text: 'Skill Statistics',
                onPressed: () {},
              ),
              OptionWidget(
                text: 'Departament Skills',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
