import 'package:flutter/material.dart';
import 'package:team_finder_app/features/auth/data/repositories/auth_repo_impl.dart';

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
              await AuthRepoImpl().createOrganizationAdminAccount(
                name: 'name',
                email: '1dadrfdgrs1111@1111hfthtf.111rgg124dasd54532323',
                password: 'password',
                organizationName: 'organizationName',
                address: 'address',
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
