import 'package:flutter/material.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/register_screen.dart';

class RegisterScreenForEmployee extends StatelessWidget {
  const RegisterScreenForEmployee({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const RegisterScreen(
      isEmployee: true,
    );
  }
}
