import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/main_wrapper.dart';
import 'package:team_finder_app/features/auth/presentation/pages/admin_login_page.dart';
import 'package:team_finder_app/features/auth/presentation/pages/admin_register_page.dart';
import 'package:team_finder_app/features/auth/presentation/pages/employee_login_page.dart';
import 'package:team_finder_app/features/auth/presentation/pages/employee_register_page.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/add_project_member_page.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/assigment_proposal_screen.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/create_project_page.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/main_project_page.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/project_details_page.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/project_members_page.dart';

@singleton
class MyAppRouter {
  final GoRouter _router = GoRouter(
    initialLocation: '/projects',
    // initialLocation: '/register/admin',
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
      ShellRoute(
          builder: (context, state, child) => MainWrapper(child: child),
          routes: [
            GoRoute(
              name: AppRouterConst.projectsMainScreen,
              path: '/projects',
              pageBuilder: (context, state) =>
                  const MaterialPage(child: ProjectsMainScreen()),
            ),
            GoRoute(
              name: AppRouterConst.projectDetailsScreen,
              path: '/projects/details/:projectId',
              pageBuilder: (context, state) => MaterialPage(
                  child: ProjectDetailsScreen(
                projectId: state.pathParameters['projectId']!,
              )),
            ),
            GoRoute(
              name: AppRouterConst.projectMembersScreen,
              path: '/projects/details/:projectId/members',
              pageBuilder: (context, state) => MaterialPage(
                  child: ProjectMembersPage(
                projectId: state.pathParameters['projectId']!,
              )),
            ),
            GoRoute(
              name: AppRouterConst.addProjectMember,
              path: '/projects/details/:projectId/members/add',
              pageBuilder: (context, state) => MaterialPage(
                  child: AddProjectMembersPage(
                projectId: state.pathParameters['projectId']!,
              )),
            ),
            GoRoute(
              name: AppRouterConst.sendAssignmentProposal,
              path: '/projects/details/:projectId/members/add/:employeeId',
              pageBuilder: (context, state) => MaterialPage(
                  child: AssignmentProposalScreen(
                projectId: state.pathParameters['projectId']!,
                employeeId: state.pathParameters['employeeId']!,
              )),
            ),
            GoRoute(
              name: AppRouterConst.createProjectScreen,
              path: '/projects/create',
              pageBuilder: (context, state) =>
                  const MaterialPage(child: CreateProjectScreen()),
            ),
            GoRoute(
              name: AppRouterConst.departamentsMainScreen,
              path: '/departaments',
              pageBuilder: (context, state) => MaterialPage(
                  child: Container(
                color: Colors.amber,
              )),
            ),
            GoRoute(
              name: AppRouterConst.settingsMainScreen,
              path: '/settings',
              pageBuilder: (context, state) => MaterialPage(
                child: Container(
                  color: Colors.blue,
                ),
              ),
            ),
            GoRoute(
              name: AppRouterConst.employeesMainScreen,
              path: '/employees',
              pageBuilder: (context, state) => MaterialPage(
                child: Container(
                  color: Colors.green,
                ),
              ),
            ),
          ]),
    ],
    errorPageBuilder: (context, state) => const MaterialPage(
      child: Scaffold(
        body: Center(
          child: Text('Page not found'),
        ),
      ),
    ),
  );

  // Getter for accessing the router instance
  GoRouter get router => _router;

  void navigateTo(String route) {
    _router.go(route);
  }
}
