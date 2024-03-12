import 'package:flutter/material.dart';
import 'package:team_finder_app/data/repositories/department_repo_impl.dart';

class TestAppPage extends StatelessWidget {
  const TestAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Test App'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await DepartmentRepoImpl().createDepartament(
                name: 'name test 2',
                organizationId: 'G21qLl1884AlgtNc1kIt',
              );
            },
            child: Text(
              'Apasa-ma',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }
}
