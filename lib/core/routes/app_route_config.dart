import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/core/util/logger.dart';
import 'package:team_finder_app/core/util/main_wrapper.dart';
import 'package:team_finder_app/core/util/secure_storage_service.dart';
import 'package:team_finder_app/features/auth/presentation/pages/admin_login_page.dart';
import 'package:team_finder_app/features/auth/presentation/pages/admin_register_page.dart';
import 'package:team_finder_app/features/auth/presentation/pages/employee_login_page.dart';
import 'package:team_finder_app/features/auth/presentation/pages/employee_register_page.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/pages/departament_details_page.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/pages/departaments_main_page.dart';
import 'package:team_finder_app/features/employee_pages/presentation/pages/employee_profile_page.dart';
import 'package:team_finder_app/features/employee_pages/presentation/pages/employees_main_page.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/add_project_member_page.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/assigment_proposal_screen.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/create_project_page.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/edit_project_screen.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/main_project_page.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/project_details_page.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/project_members_page.dart';

@singleton
class MyAppRouter {
  final GoRouter _router = GoRouter(
    // initialLocation: '/firstPage',
    initialLocation: '/register/admin',
    routes: [
      GoRoute(
        name: AppRouterConst.registerAdminName,
        path: '/register/admin',
        pageBuilder: (context, state) =>
            const MaterialPage(child: RegisterScreenForAdmin()),
        redirect: (ctx, state) async {
          final token =
              await SecureStorageService().read(key: StorageConstants.token);
          if (token == null) {
            return '/register/admin';
          }

          final isExpired = JwtDecoder.isExpired(token);

          if (isExpired) {
            await SecureStorageService().delete(key: StorageConstants.token);
            return '/register/admin';
          }

          final userData = JwtDecoder.decode(token);

          Logger.info('User data', userData.toString());

          return '/${userData['id']}/projects';
        },
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
          path: '/register/employee/:organizationId',
          pageBuilder: (context, state) {
            final organizationId = state.pathParameters['organizationId'];
            if (organizationId != null) {
              return MaterialPage(
                child: RegisterScreenForEmployee(
                  organizationId: organizationId,
                ),
              );
            } else {
              return MaterialPage(
                  child: Center(
                      child: Text(
                          'Linkul nu este valid : ${state.pathParameters}')));
            }
          }),
      ShellRoute(
          builder: (context, state, child) => MainWrapper(child: child),
          routes: [
            GoRoute(
              name: AppRouterConst.projectsMainScreen,
              path: '/:userId/projects',
              pageBuilder: (context, state) => MaterialPage(
                  child: ProjectsMainScreen(
                userId: state.pathParameters['userId']!,
              )),
            ),
            GoRoute(
              name: AppRouterConst.projectDetailsScreen,
              path: '/:userId/projects/details/:projectId',
              pageBuilder: (context, state) => MaterialPage(
                  child: ProjectDetailsScreen(
                projectId: state.pathParameters['projectId']!,
                userId: state.pathParameters['userId']!,
              )),
            ),
            GoRoute(
              name: AppRouterConst.projectMembersScreen,
              path: '/:userId/projects/details/:projectId/members',
              pageBuilder: (context, state) => MaterialPage(
                  child: ProjectMembersPage(
                projectId: state.pathParameters['projectId']!,
                userId: state.pathParameters['userId']!,
              )),
            ),
            GoRoute(
              name: AppRouterConst.addProjectMember,
              path: '/:userId/projects/details/:projectId/members/add',
              pageBuilder: (context, state) => MaterialPage(
                  child: AddProjectMembersPage(
                projectId: state.pathParameters['projectId']!,
                userId: state.pathParameters['userId']!,
              )),
            ),
            GoRoute(
              name: AppRouterConst.sendAssignmentProposal,
              path:
                  '/:userId/projects/details/:projectId/members/add/:employeeId',
              pageBuilder: (context, state) => MaterialPage(
                  child: AssignmentProposalScreen(
                projectId: state.pathParameters['projectId']!,
                employeeId: state.pathParameters['employeeId']!,
                userId: state.pathParameters['userId']!,
              )),
            ),
            GoRoute(
              name: AppRouterConst.createProjectScreen,
              path: '/:userId/projects/create',
              pageBuilder: (context, state) => MaterialPage(
                  child: CreateProjectScreen(
                userId: state.pathParameters['userId']!,
              )),
            ),
            GoRoute(
              name: AppRouterConst.editProjectScreen,
              path: '/:userId/projects/edit/:projectId',
              pageBuilder: (context, state) => MaterialPage(
                  child: EditProjectScreen(
                projectId: state.pathParameters['projectId']!,
                userId: state.pathParameters['userId']!,
              )),
            ),
            GoRoute(
                name: AppRouterConst.departamentsMainScreen,
                path: '/:userId/departaments',
                pageBuilder: (context, state) => MaterialPage(
                        child: DepartamentMainPage(
                      userId: state.pathParameters['userId']!,
                    )),
                routes: [
                  GoRoute(
                    name: AppRouterConst.departamentsDetailsPage,
                    path: ':departamentId/details',
                    pageBuilder: (context, state) => MaterialPage(
                        child: DepartamentDetailsPage(
                      userId: state.pathParameters['userId']!,
                      departamentId: state.pathParameters['departamentId']!,
                    )),
                  ),
                ]),
            GoRoute(
              name: AppRouterConst.settingsMainScreen,
              path: '/:userId/settings',
              pageBuilder: (context, state) => MaterialPage(
                child: Container(
                  color: Colors.blue,
                ),
              ),
            ),
            GoRoute(
              name: AppRouterConst.employeesMainScreen,
              path: '/:userId/employees',
              pageBuilder: (context, state) => MaterialPage(
                child: EmployeeMainPage(
                  userId: state.pathParameters['userId']!,
                ),
              ),
            ),
            GoRoute(
              name: AppRouterConst.employeeProfileScreen,
              path: '/:userId/employees/profile/:employeeId',
              pageBuilder: (context, state) => MaterialPage(
                child: EmployeeProfilePage(
                  userId: state.pathParameters['userId']!,
                  employeeId: state.pathParameters['employeeId']!,
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
