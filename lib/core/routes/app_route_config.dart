import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/auth/presentation/pages/admin_login_page.dart';
import 'package:team_finder_app/features/auth/presentation/pages/admin_register_page.dart';
import 'package:team_finder_app/features/auth/presentation/pages/employee_login_page.dart';
import 'package:team_finder_app/features/auth/presentation/pages/employee_register_page.dart';

class MyAppRouter {
  GoRouter router = GoRouter(
    initialLocation: '/registerAdmin',
    routes: [
      GoRoute(
        name: AppRouterConst.registerAdminName,
        path: '/registerAdmin',
        pageBuilder: (context, state) =>
            const MaterialPage(child: RegisterScreenForAdmin()),
      ),
      GoRoute(
        name: AppRouterConst.loginEmployeeName,
        path: '/loginEmployee',
        pageBuilder: (context, state) =>
            const MaterialPage(child: EmployeeLoginPage()),
      ),
      GoRoute(
        name: AppRouterConst.loginAdminName,
        path: '/loginAdmin',
        pageBuilder: (context, state) =>
            const MaterialPage(child: AdminLoginPage()),
      ),
      GoRoute(
        name: AppRouterConst.registerEmployeeName,
        path: '/registerEmployee',
        pageBuilder: (context, state) =>
            const MaterialPage(child: RegisterScreenForEmployee()),
      ),
    ],
    errorPageBuilder: (context, state) => const MaterialPage(
      child: Scaffold(
        body: Center(
          child: Text('Page not found'),
        ),
      ),
    ),
  );
}
