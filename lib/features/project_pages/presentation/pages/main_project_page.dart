import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_segmented_button.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/project_widget.dart';

class ProjectsMainScreen extends StatelessWidget {
  const ProjectsMainScreen({super.key, required this.userId});

  final String userId;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) {
        return MobileMainProjectPage(userId: userId);
      },
      desktop: (context) {
        return DesktopMainProjectPage(userId: userId);
      },
      tablet: (context) {
        return DesktopMainProjectPage(userId: userId);
      },
    );
  }
}

class MobileMainProjectPage extends StatelessWidget {
  const MobileMainProjectPage({
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
          //TODO George Luta : e pus pentru testare sterge-l
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
                const Center(child: CustomSegmentedButton()),
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: ListView.builder(
                      // physics: const NeverScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProjectWidget(
                            onPressed: () {
                              //TODO: navigate to project details, pass project id
                              context.goNamed(
                                  AppRouterConst.projectDetailsScreen,
                                  pathParameters: {
                                    'projectId': '1',
                                    'userId': userId
                                  });
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
          },
        ),
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
          //TODO George Luta : e pus pentru testare sterge-l
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
            return SingleChildScrollView(
              child: Column(
                children: [
                  ProjectsListWidget(
                    userId: userId,
                    projects: [],
                    title: 'Past Projects',
                  ),
                  ProjectsListWidget(
                    userId: userId,
                    projects: [],
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
  final List<String> projects;
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
