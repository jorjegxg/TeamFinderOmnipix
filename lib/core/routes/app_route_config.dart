import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/auth/presentation/pages/admin_login_page.dart';
import 'package:team_finder_app/features/auth/presentation/pages/admin_register_page.dart';
import 'package:team_finder_app/features/auth/presentation/pages/employee_login_page.dart';
import 'package:team_finder_app/features/auth/presentation/pages/employee_register_page.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/main_project_page.dart';

class MyAppRouter {
  final GoRouter _router = GoRouter(
    initialLocation: '/projects',
    routes: [
      GoRoute(
        name: AppRouterConst.registerAdminName,
        path: '/register/admin',
        pageBuilder: (context, state) =>
            const MaterialPage(child: RegisterScreenForAdmin()),
      ),
      GoRoute(
        name: AppRouterConst.loginEmployeeName,
        path: '/login/employee',
        pageBuilder: (context, state) =>
            const MaterialPage(child: EmployeeLoginPage()),
      ),
      GoRoute(
        name: AppRouterConst.loginAdminName,
        path: '/login/admin',
        pageBuilder: (context, state) =>
            const MaterialPage(child: AdminLoginPage()),
      ),
      GoRoute(
        name: AppRouterConst.registerEmployeeName,
        path: '/register/employee',
        pageBuilder: (context, state) =>
            const MaterialPage(child: RegisterScreenForEmployee()),
      ),
      GoRoute(
        name: AppRouterConst.projectsMainScreen,
        path: '/projects',
        pageBuilder: (context, state) =>
            const MaterialPage(child: ProjectsMainScreen()),
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

  static final MyAppRouter _instance = MyAppRouter._internal();

  factory MyAppRouter() {
    return _instance;
  }

  MyAppRouter._internal();

  // Getter for accessing the router instance
  GoRouter get router => _router;

  void navigateTo(String route) {
    _router.go(route);
  }
}