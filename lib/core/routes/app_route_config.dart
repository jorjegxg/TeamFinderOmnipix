import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
import 'package:team_finder_app/features/departaments_pages/presentation/pages/add_employee_departament.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/pages/confirmations_page.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/pages/departament_details_page.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/pages/departament_employees_page.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/pages/departament_projects_page.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/pages/departament_skills_page.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/pages/departaments_main_page.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/pages/skill_validations_page.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/pages/skills_statistics_page.dart';
import 'package:team_finder_app/features/employee_pages/presentation/pages/employee_profile_page.dart';
import 'package:team_finder_app/features/employee_pages/presentation/pages/employees_main_page.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/Project_inactive_details_screen.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/add_project_member_page.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/assigment_proposal_screen.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/create_project_page.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/edit_project_screen.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/main_project_page.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/project_details_page.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/project_members_page.dart';
import 'package:team_finder_app/features/settings/presentation/pages/add_personal_skill.dart';
import 'package:team_finder_app/features/settings/presentation/pages/create_skill_page.dart';
import 'package:team_finder_app/features/settings/presentation/pages/main_settings_page.dart';
import 'package:team_finder_app/features/settings/presentation/pages/owned_skills_page.dart';
import 'package:team_finder_app/features/settings/presentation/pages/personal_skills_page.dart';
import 'package:team_finder_app/features/settings/presentation/pages/team_roles_page.dart';

@singleton
class MyAppRouter {
  final GoRouter _router = GoRouter(
    redirect: (_, state) async {
      final token =
          await SecureStorageService().read(key: StorageConstants.token);
      if (state.fullPath == '/register/admin' ||
          state.fullPath == '/register/employee/:organizationId' ||
          state.fullPath == '/login/admin' ||
          state.fullPath == '/login/employee') {
        return null;
      }
      if (token == null) {
        return '/register/admin';
      }

      final isExpired = JwtDecoder.isExpired(token);

      if (isExpired) {
        await SecureStorageService().delete(key: StorageConstants.token);
        return '/register/admin';
      }

      return null;
    },
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
        path: '/login/employee/:organizationId',
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
                routes: [
                  GoRoute(
                      path: "inactiveDetails",
                      name: AppRouterConst.projectInactiveDetailsScreen,
                      pageBuilder: (context, state) {
                        return MaterialPage(
                          child: ProjectInactiveDetailsScreen(
                            userId: state.pathParameters['userId']!,
                            project: state.extra as ProjectEntity,
                          ),
                        );
                      }),
                  GoRoute(
                      name: AppRouterConst.projectDetailsScreen,
                      path: 'details/:projectId',
                      pageBuilder: (context, state) => MaterialPage(
                              child: ProjectDetailsScreen(
                            projectId: state.pathParameters['projectId']!,
                            userId: state.pathParameters['userId']!,
                            project: state.extra as ProjectEntity,
                          )),
                      routes: [
                        GoRoute(
                            name: AppRouterConst.projectMembersScreen,
                            path: 'members',
                            pageBuilder: (context, state) => MaterialPage(
                                    child: ProjectMembersPage(
                                  projectId: state.pathParameters['projectId']!,
                                  userId: state.pathParameters['userId']!,
                                  project: state.extra as ProjectEntity,
                                )),
                            routes: [
                              GoRoute(
                                  name: AppRouterConst.addProjectMember,
                                  path: 'add',
                                  pageBuilder: (context, state) => MaterialPage(
                                          child: AddProjectMembersPage(
                                        projectId:
                                            state.pathParameters['projectId']!,
                                        userId: state.pathParameters['userId']!,
                                        project: state.extra as ProjectEntity,
                                      )),
                                  routes: [
                                    GoRoute(
                                      name:
                                          AppRouterConst.sendAssignmentProposal,
                                      path: ':employeeId/:workingHours',
                                      pageBuilder: (context, state) =>
                                          MaterialPage(
                                              child: AssignmentProposalScreen(
                                        projectId:
                                            state.pathParameters['projectId']!,
                                        employeeId:
                                            state.pathParameters['employeeId']!,
                                        userId: state.pathParameters['userId']!,
                                        project: state.extra as ProjectEntity,
                                        workingHours: state
                                            .pathParameters['workingHours']!,
                                      )),
                                    ),
                                  ]),
                            ]),
                      ]),
                  GoRoute(
                    name: AppRouterConst.createProjectScreen,
                    path: 'create',
                    pageBuilder: (context, state) => MaterialPage(
                        child: CreateProjectScreen(
                      userId: state.pathParameters['userId']!,
                    )),
                  ),
                  GoRoute(
                    name: AppRouterConst.editProjectScreen,
                    path: 'edit/:projectId',
                    pageBuilder: (context, state) => MaterialPage(
                        child: EditProjectScreen(
                      projectId: state.pathParameters['projectId']!,
                      userId: state.pathParameters['userId']!,
                      project: state.extra as ProjectEntity,
                    )),
                  ),
                ]),
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
                      path: ':departamentId/:departamentName/details',
                      pageBuilder: (context, state) => MaterialPage(
                            child: DepartamentDetailsPage(
                              userId: state.pathParameters['userId']!,
                              departamentId:
                                  state.pathParameters['departamentId']!,
                              departamentName:
                                  state.pathParameters['departamentName']!,
                            ),
                          ),
                      routes: [
                        GoRoute(
                          name: AppRouterConst.departamentEmployeesPage,
                          path: 'employees',
                          pageBuilder: (context, state) => MaterialPage(
                            child: DepartamentEmployeesPage(
                              userId: state.pathParameters['userId']!,
                              departamentId:
                                  state.pathParameters['departamentId']!,
                              departamentName:
                                  state.pathParameters['departamentName']!,
                            ),
                          ),
                          routes: [
                            GoRoute(
                              name: AppRouterConst.addEmployeeToDepartament,
                              path: 'add',
                              pageBuilder: (context, state) => MaterialPage(
                                child: AddEmployeeToDepartamentPage(
                                  userId: state.pathParameters['userId']!,
                                  departamentId:
                                      state.pathParameters['departamentId']!,
                                  departamentName:
                                      state.pathParameters['departamentName']!,
                                ),
                              ),
                            ),
                          ],
                        ),
                        GoRoute(
                            name: AppRouterConst.departamentProjectsPage,
                            path: 'projects',
                            pageBuilder: (context, state) {
                              return MaterialPage(
                                child: DepartamentProjectsPage(
                                  userId: state.pathParameters['userId']!,
                                  departamentId:
                                      state.pathParameters['departamentId']!,
                                  departamentName:
                                      state.pathParameters['departamentName']!,
                                ),
                              );
                            }),
                        GoRoute(
                            name: AppRouterConst.confirmationsPage,
                            path: 'confirmations',
                            pageBuilder: (context, state) {
                              return MaterialPage(
                                child: ConfirmationPage(
                                  userId: state.pathParameters['userId']!,
                                  departamentId:
                                      state.pathParameters['departamentId']!,
                                  departamentName:
                                      state.pathParameters['departamentName']!,
                                ),
                              );
                            }),
                        GoRoute(
                            name: AppRouterConst.skillValidationPage,
                            path: 'skill_validations',
                            pageBuilder: (context, state) {
                              return MaterialPage(
                                child: SkillValidationPage(
                                  userId: state.pathParameters['userId']!,
                                  departamentId:
                                      state.pathParameters['departamentId']!,
                                  departamentName:
                                      state.pathParameters['departamentName']!,
                                ),
                              );
                            }),
                        GoRoute(
                            name: AppRouterConst.skillStatisticsPage,
                            path: 'skill_statistics',
                            pageBuilder: (context, state) {
                              return MaterialPage(
                                child: SkillStatisticsPage(
                                  userId: state.pathParameters['userId']!,
                                  departamentId:
                                      state.pathParameters['departamentId']!,
                                  departamentName:
                                      state.pathParameters['departamentName']!,
                                ),
                              );
                            }),
                        GoRoute(
                          name: AppRouterConst.departamentSkillsPage,
                          path: 'skills',
                          pageBuilder: (context, state) {
                            return MaterialPage(
                              child: DepartmentSkillsPage(
                                userId: state.pathParameters['userId']!,
                                departamentId:
                                    state.pathParameters['departamentId']!,
                                departamentName:
                                    state.pathParameters['departamentName']!,
                              ),
                            );
                          },
                        ),
                      ]),
                ]),
            GoRoute(
                name: AppRouterConst.settingsMainScreen,
                path: '/:userId/settings',
                pageBuilder: (context, state) => MaterialPage(
                      child: MainSettingsPage(
                        userId: state.pathParameters['userId']!,
                      ),
                    ),
                routes: [
                  GoRoute(
                    name: AppRouterConst.personalSkillsPage,
                    path: 'personal_skills',
                    pageBuilder: (context, state) => MaterialPage(
                      child: PersonalSkillsPage(
                        userId: state.pathParameters['userId']!,
                      ),
                    ),
                    routes: [
                      GoRoute(
                        name: AppRouterConst.addSkillPage,
                        path: 'add',
                        pageBuilder: (context, state) => MaterialPage(
                          child: AddPersonalSkillPage(
                            userId: state.pathParameters['userId']!,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GoRoute(
                      name: AppRouterConst.teamRolesPage,
                      path: 'team_roles',
                      pageBuilder: (context, state) {
                        return MaterialPage(
                          child: TeamRolesPage(
                            userId: state.pathParameters['userId']!,
                          ),
                        );
                      }),
                  GoRoute(
                      name: AppRouterConst.ownedSkillPage,
                      path: 'ownedSkills',
                      pageBuilder: (context, state) => MaterialPage(
                            child: OwnedSkillsPage(
                              userId: state.pathParameters['userId']!,
                            ),
                          ),
                      routes: [
                        GoRoute(
                          name: AppRouterConst.createSkillPage,
                          path: 'createSkill',
                          pageBuilder: (context, state) => MaterialPage(
                            child: CreateSkillPage(
                              userId: state.pathParameters['userId']!,
                            ),
                          ),
                        ),
                      ]),
                ]),
            GoRoute(
                name: AppRouterConst.employeesMainScreen,
                path: '/:userId/employees',
                pageBuilder: (context, state) => MaterialPage(
                      child: EmployeeMainPage(
                        userId: state.pathParameters['userId']!,
                      ),
                    ),
                routes: [
                  GoRoute(
                    name: AppRouterConst.employeeProfileScreen,
                    path:
                        'profile/:employeeId/:employeeName/:employeeEmail/:isCurrentUser',
                    pageBuilder: (context, state) => MaterialPage(
                      child: EmployeeProfilePage(
                        userId: state.pathParameters['userId']!,
                        employeeId: state.pathParameters['employeeId']!,
                        employeeName: state.pathParameters['employeeName']!,
                        employeeEmail: state.pathParameters['employeeEmail']!,
                        isCurrentUser:
                            bool.parse(state.pathParameters['isCurrentUser']!),
                      ),
                    ),
                  ),
                ]),
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
