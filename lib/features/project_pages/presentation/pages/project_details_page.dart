import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';
import 'package:team_finder_app/features/project_pages/presentation/bloc/skill_req_provider.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/project_details_body.dart';
import 'package:team_finder_app/injection.dart';

class ProjectDetailsScreen extends HookWidget {
  const ProjectDetailsScreen(
      {required this.userId,
      super.key,
      required this.projectId,
      required this.project});
  final String projectId;
  final String userId;
  final ProjectEntity project;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.goNamed(AppRouterConst.projectsMainScreen,
                pathParameters: {'userId': userId}),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.black),
              onPressed: () {
                context.goNamed(
                  AppRouterConst.editProjectScreen,
                  pathParameters: {'projectId': projectId, 'userId': userId},
                  extra: project,
                );
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
                    //MobileProjectDetailsBody(),
                    Expanded(
                      child: ScreenTypeLayout.builder(
                        mobile: (context) {
                          return MobileProjectDetailsBody(
                            project: project,
                          );
                        },
                        desktop: (context) {
                          return DesktopProjectDetailsScreen(
                            userId: userId,
                          );
                        },
                        tablet: (context) {
                          return TabletProjectDetailsScreen(
                            userId: userId,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: 'View Members',
                            onPressed: () {
                              context.goNamed(
                                AppRouterConst.projectMembersScreen,
                                pathParameters: {
                                  'projectId': projectId,
                                  'userId': userId
                                },
                                extra: project,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomButton(
                            text: 'Add Skill Requirement',
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ChooseSkillRequirement(
                                      projectId: projectId,
                                    );
                                  });
                            },
                          ),
                        ),
                      ],
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

class ChooseSkillRequirement extends StatelessWidget {
  const ChooseSkillRequirement({
    required this.projectId,
    super.key,
  });
  final String projectId;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SkillReqProvider>(
      create: (context) => getIt<SkillReqProvider>()..fetchSkills(),
      child: Builder(builder: (context) {
        return Consumer<SkillReqProvider>(
          builder: (context, provider, child) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Add a skill',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'You can choose any skills from the list',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: ListView.builder(
                        itemCount: provider.skills.length,
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                            enabled: provider.skills.values.elementAt(index),
                            trailing: Checkbox(
                              checkColor: Colors.white,
                              value: provider.skills.values.elementAt(index),
                              onChanged: (bool? value) {
                                provider.setSkillBool(
                                    provider.skills.keys.elementAt(index),
                                    value!);
                              },
                            ),
                            title: Text(
                              provider.skills.keys
                                  .elementAt(index)
                                  .keys
                                  .first
                                  .name,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            children: [
                              NumberPicker(
                                axis: Axis.horizontal,
                                minValue: 0,
                                maxValue: 5,
                                value: provider.skills.keys
                                    .elementAt(index)
                                    .values
                                    .first,
                                onChanged: (int number) {
                                  provider.setSkillInt(
                                      provider.skills.keys.elementAt(index),
                                      number);
                                },
                              ),
                            ],
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await provider.postSkillReq(projectId);
                          if (!context.mounted) return;
                          Navigator.pop(context);
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
