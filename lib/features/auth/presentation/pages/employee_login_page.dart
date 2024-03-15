import 'package:flutter/material.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/login_page.dart';

class EmployeeLoginPage extends StatelessWidget {
  const EmployeeLoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const LoginScreen(
      isEmployee: true,
    );
  }
}
