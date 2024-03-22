import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/core/util/snack_bar.dart';
import 'package:team_finder_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:team_finder_app/features/employee_pages/presentation/provider/employee_roles_provider.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';
import 'package:team_finder_app/features/project_pages/presentation/bloc/projects_bloc.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_segmented_button.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/project_widget.dart';

class ProjectsMainScreen extends StatelessWidget {
  const ProjectsMainScreen({super.key, required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => MobileProjectScreen(
        userId: userId,
      ),
      desktop: (BuildContext context) => DesktopMainProjectPage(
        userId: userId,
      ),
    );
  }
}

class MobileProjectScreen extends StatelessWidget {
  const MobileProjectScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          showSnackBar(context, state.message);
        }
      },
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            if (context.read<ProjectsBloc>().state.switchState ==
                StatusOfProject.active) {
              context.read<ProjectsBloc>().add(
                    const GetActiveProjectPages(),
                  );
            } else {
              context.read<ProjectsBloc>().add(
                    const GetInActiveProjectPages(),
                  );
            }
          },
          child: Scaffold(
            floatingActionButton: Consumer<EmployeeRolesProvider>(
              builder: (context, EmployeeRolesProvider provider, _) {
                if (!provider.isProjectManager) return Container();
                return FloatingActionButton(
                  onPressed: () {
                    context.goNamed(AppRouterConst.createProjectScreen,
                        pathParameters: {'userId': userId});
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const Icon(Icons.add),
                );
              },
            ),
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Projects',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogoutRequested(
                          context: context,
                        ));
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            body: Sizer(
              builder: (BuildContext context, Orientation orientation,
                  DeviceType deviceType) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<ProjectsBloc, ProjectsState>(
                      builder: (context, state) {
                        return Center(
                          child: CustomSegmentedButton(
                            currentView: state.switchState,
                            onSelectionChanged: (value) {
                              context
                                  .read<ProjectsBloc>()
                                  .add(SwitchProjectPages(value.first));
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      child: BlocBuilder<ProjectsBloc, ProjectsState>(
                        builder: (context, state) {
                          if (state.isLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state.activeProjects.isEmpty &&
                              state.inactiveProjects.isEmpty) {
                            return const NotFoundWidget(
                                text: 'Projects not found');
                          }
                          if (state.errorMessage.isNotEmpty) {
                            return Center(
                              child: Text(state.errorMessage),
                            );
                          }

                          if (state.switchState == StatusOfProject.active) {
                            if (state.activeProjects.isEmpty) {
                              return const Center(
                                child: Text('No active projects found'),
                              );
                            }
                            return ListView.builder(
                                itemCount: state.activeProjects.length,
                                itemBuilder: (context, index) {
                                  String techStackString =
                                      getTechStringActive(state, index);
                                  //make string for team roles
                                  String teamRoleString =
                                      getTeamRoleStringActive(state, index);
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ProjectWidget(
                                      onPressed: () {
                                        //TODO: navigate to project details, pass project id
                                        Hive.box<ProjectEntity>(
                                                HiveConstants.projectEntityBox)
                                            .put(
                                          state.activeProjects[index].id,
                                          state.activeProjects[index],
                                        );
                                        context.goNamed(
                                          AppRouterConst.projectDetailsScreen,
                                          pathParameters: {
                                            'projectId':
                                                state.activeProjects[index].id,
                                            'userId': userId
                                          },
                                          extra: state.activeProjects[index],
                                        );
                                      },
                                      mainTitle:
                                          state.activeProjects[index].name,
                                      title1: 'Roles:',
                                      title2: 'Tehnologies Stack:',
                                      content1: teamRoleString,
                                      content2: techStackString,
                                    ),
                                  );
                                });
                          } else {
                            if (state.inactiveProjects.isEmpty) {
                              return const NotFoundWidget(
                                text: 'Projects not found',
                              );
                            }
                            return ListView.builder(
                                itemCount: state.inactiveProjects.length,
                                itemBuilder: (context, index) {
                                  String techStackString =
                                      getTechStringInactive(state, index);
                                  String teamRoleString =
                                      getTeamRoleStringInactive(state, index);

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ProjectWidget(
                                      onPressed: () async {
                                        await Hive.box<ProjectEntity>(
                                                HiveConstants.projectEntityBox)
                                            .put(
                                          state.inactiveProjects[index].id,
                                          state.inactiveProjects[index],
                                        );
                                        //TODO: navigate to project details, pass project id
                                        context.goNamed(
                                          AppRouterConst
                                              .projectInactiveDetailsScreen,
                                          pathParameters: {'userId': userId},
                                          extra: state.inactiveProjects[index],
                                        );
                                      },
                                      mainTitle:
                                          state.inactiveProjects[index].name,
                                      title1: 'Roles:',
                                      title2: 'Tehnologies Stack:',
                                      content1: teamRoleString,
                                      content2: techStackString,
                                    ),
                                  );
                                });
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String getTeamRoleStringActive(ProjectsState state, int index) {
    String teamRoleString = '';
    for (int i = 0; i < state.activeProjects[index].teamRoles.length; i++) {
      if (i == state.activeProjects[index].teamRoles.length - 1) {
        teamRoleString +=
            state.activeProjects[index].teamRoles.keys.elementAt(i).name;
      } else {
        teamRoleString +=
            '${state.activeProjects[index].teamRoles.keys.elementAt(i).name}, ';
      }
    }
    return teamRoleString;
  }

  String getTechStringActive(ProjectsState state, int index) {
    String techStackString = '';
    for (var tech in state.activeProjects[index].technologyStack) {
      if (state.activeProjects[index].technologyStack.indexOf(tech) !=
          state.activeProjects[index].technologyStack.length - 1) {
        techStackString += '${tech.name}, ';
      } else {
        techStackString += tech.name;
      }
    }
    return techStackString;
  }

  String getTeamRoleStringInactive(ProjectsState state, int index) {
    String teamRoleString = '';
    for (int i = 0; i < state.inactiveProjects[index].teamRoles.length; i++) {
      if (i == state.inactiveProjects[index].teamRoles.length - 1) {
        teamRoleString +=
            state.inactiveProjects[index].teamRoles.keys.elementAt(i).name;
      } else {
        teamRoleString +=
            '${state.inactiveProjects[index].teamRoles.keys.elementAt(i).name}, ';
      }
    }
    return teamRoleString;
  }

  String getTechStringInactive(ProjectsState state, int index) {
    String techStackString = '';
    for (var tech in state.inactiveProjects[index].technologyStack) {
      if (state.inactiveProjects[index].technologyStack.indexOf(tech) !=
          state.inactiveProjects[index].technologyStack.length - 1) {
        techStackString += '${tech.name}, ';
      } else {
        techStackString += tech.name;
      }
    }
    return techStackString;
  }
}

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({
    required this.text,
    super.key,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

class DesktopMainProjectPage extends StatelessWidget {
  const DesktopMainProjectPage({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.goNamed(AppRouterConst.createProjectScreen,
                pathParameters: {'userId': userId});
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Projects',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Sizer(
          builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) {
            return SingleChildScrollView(
              child: BlocBuilder<ProjectsBloc, ProjectsState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      ProjectsListWidget(
                        userId: userId,
                        projects: state.activeProjects,
                        title: 'Active Projects',
                        isActive: true,
                      ),
                      ProjectsListWidget(
                        userId: userId,
                        projects: state.inactiveProjects,
                        title: 'Past Projects',
                        isActive: false,
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProjectsListWidget extends StatelessWidget {
  const ProjectsListWidget({
    super.key,
    required this.userId,
    required this.projects,
    required this.title,
    required this.isActive,
  });

  final String userId;
  final List<ProjectEntity> projects;
  final String title;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        const SizedBox(
          height: 40,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 300,
          ),
          child: projects.isEmpty
              ? const NotFoundWidget(
                  text: 'Projects not found',
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProjectWidget(
                          onPressed: () async {
                            await Hive.box<ProjectEntity>(
                                    HiveConstants.projectEntityBox)
                                .put(
                              projects[index].id,
                              projects[index],
                            );
                            if (isActive) {
                              context.goNamed(
                                  AppRouterConst.projectDetailsScreen,
                                  pathParameters: {
                                    'projectId': projects[index].id,
                                    'userId': userId
                                  },
                                  extra: projects[index]);
                            } else {
                              context.goNamed(
                                  AppRouterConst.projectInactiveDetailsScreen,
                                  pathParameters: {'userId': userId},
                                  extra: projects[index]);
                            }
                          },
                          mainTitle: projects[index].name,
                          title1: 'Roles:',
                          title2: 'Tehnologies Stack:',
                          content1: projects[index]
                              .teamRoles
                              .keys
                              .map((e) => e.name)
                              .toList()
                              .join(', '),
                          content2: projects[index]
                              .technologyStack
                              .map((e) => e.name)
                              .toList()
                              .join(', ')),
                    );
                  }),
        ),
      ],
    );
  }
}
