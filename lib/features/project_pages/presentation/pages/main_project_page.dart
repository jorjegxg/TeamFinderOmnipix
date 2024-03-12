import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_segmented_button.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/project_widget.dart';

class ProjectsMainScreen extends StatelessWidget {
  const ProjectsMainScreen({super.key, required this.userId});

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
