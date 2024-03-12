import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/register_button.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/project_details_body.dart';

class ProjectDetailsScreen extends HookWidget {
  const ProjectDetailsScreen({super.key, required this.projectId});
  final String projectId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.goNamed(AppRouterConst.projectsMainScreen),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.black),
              onPressed: () {
                //TODO: implement edit project
              },
            ),
          ],
          centerTitle: true,
          title: Text(
            'Project Details',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Sizer(
          builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const ProjectDetailsBody(),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: 'View Members',
                      onPressed: () {
                        context.goNamed(
                          AppRouterConst.projectMembersScreen,
                          pathParameters: {'projectId': projectId},
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
