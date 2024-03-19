import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/snack_bar.dart';
import 'package:team_finder_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';
import 'package:team_finder_app/features/project_pages/presentation/bloc/projects_bloc.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_segmented_button.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/project_widget.dart';
import 'package:team_finder_app/injection.dart';

class ProjectsMainScreen extends StatefulWidget {
  const ProjectsMainScreen({super.key, required this.userId});

  final String userId;

  @override
  State<ProjectsMainScreen> createState() => _ProjectsMainScreenState();
}

class _ProjectsMainScreenState extends State<ProjectsMainScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getIt<ProjectsBloc>().add(const GetActiveProjectPages());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          showSnackBar(context, state.message);
        }
      },
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.goNamed(AppRouterConst.createProjectScreen,
                  pathParameters: {'userId': widget.userId});
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
          body: RefreshIndicator(
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
            child: Sizer(
              builder: (BuildContext context, Orientation orientation,
                  DeviceType deviceType) {
                return RefreshIndicator(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      // BlocBuilder<ProjectsBloc, ProjectsState>(
                      //   builder: (context, state) {
                      //     if (state is ProjectsLoaded) {
                      //       if (state.switchState == ProjectStatus.active) {
                      //         {
                      // return
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
                      //  }
                      //       } else {
                      //         return Center(
                      //           child: CustomSegmentedButton(
                      //             currentView: ProjectStatus.past,
                      //             onSelectionChanged: (value) {
                      //               context
                      //                   .read<ProjectsBloc>()
                      //                   .add(SwitchProjectPages(value.first));
                      //             },
                      //           ),
                      //         );
                      //       }
                      //     } else {
                      //       return const Center(
                      //         child: CircularProgressIndicator(),
                      //       );
                      //     }
                      //   },
                      // ),
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
                              return const Center(
                                child: Text('No projects found'),
                              );
                            }
                            if (state.errorMessage.isNotEmpty) {
                              return Center(
                                child: Text(state.errorMessage),
                              );
                            }
                            // if (stat) {
                            //   if (state.switchState == StatusOfProject.active) {
                            //     return ProjectsListWidget(
                            //       userId: userId,
                            //       projects: state.activeProjects!,
                            //       title: 'Active Projects',
                            //     );
                            //   } else {
                            //     return ProjectsListWidget(
                            //       userId: userId,
                            //       projects: state.inactiveProjects!,
                            //       title: 'Past Projects',
                            //     );
                            //   }
                            // }
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
                                          context.goNamed(
                                            AppRouterConst.projectDetailsScreen,
                                            pathParameters: {
                                              'projectId': state
                                                  .activeProjects[index].id,
                                              'userId': widget.userId
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
                                return const Center(
                                  child: Text('No active projects found'),
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
                                        onPressed: () {
                                          context.goNamed(
                                              AppRouterConst
                                                  .projectDetailsScreen,
                                              pathParameters: {
                                                'projectId': state
                                                    .inactiveProjects[index].id,
                                                'userId': widget.userId
                                              });
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
                    ],
                  ),
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
              child: Column(
                children: [
                  ProjectsListWidget(
                    userId: userId,
                    projects: const [],
                    title: 'Past Projects',
                  ),
                  ProjectsListWidget(
                    userId: userId,
                    projects: const [],
                    title: 'Active Projects',
                  ),
                ],
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
  });

  final String userId;
  final List<ProjectEntity> projects;
  final String title;
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
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProjectWidget(
                    onPressed: () {
                      //TODO: navigate to project details, pass project id
                      context.goNamed(AppRouterConst.projectDetailsScreen,
                          pathParameters: {'projectId': '1', 'userId': userId});
                    },
                    mainTitle: 'Project Name',
                    title1: 'Roles:',
                    title2: 'Tehnologies Stack:',
                    content1: 'Roles....',
                    content2: 'Tehnologies....',
                  ),
                );
              }),
        ),
      ],
    );
  }
}
