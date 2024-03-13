import 'package:flutter/material.dart';
import 'package:team_finder_app/core/util/logger.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/register_screen.dart';

class RegisterScreenForEmployee extends StatelessWidget {
  const RegisterScreenForEmployee({
    super.key,
    required this.organizationId,
  });
  final String organizationId;

  @override
  Widget build(BuildContext context) {
    Logger.info('RegisterScreenForEmployee', 'organizationId: $organizationId');
    return const RegisterScreen(
      isEmployee: true,
    );
  }
}
