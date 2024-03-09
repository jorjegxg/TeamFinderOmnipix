import 'package:flutter/material.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/login_page.dart';

class AdminLoginPage extends StatelessWidget {
  const AdminLoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const LoginScreen(
      isEmployee: false,
    );
  }
}
