import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/register_button.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_text_container.dart';

import 'package:team_finder_app/features/project_pages/presentation/widgets/view_list_dialog.dart';

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
                    Expanded(
                      child: Card(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        child: SingleChildScrollView(
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5),
                                      Text('Project period',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall),
                                      const CustomTextContainer(
                                        text: 'Project Name',
                                      ),
                                      const SizedBox(height: 20),
                                      Text('Project period',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall),
                                      const CustomTextContainer(
                                        text: 'Project period',
                                      ),
                                      const SizedBox(height: 20),
                                      Text('Project Status',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall),
                                      const CustomTextContainer(
                                        text: 'Project status',
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Start Date:',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall),
                                          Text('10/02/2022',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall),
                                          SizedBox(width: 10.w),
                                          Text('End Date:',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall),
                                          Text('10/02/2024',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomButton(
                                            text: 'View tehnologies',
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      const ViewListDialog(
                                                        list: ['1', '2', '3'],
                                                        title:
                                                            'View Technologies',
                                                      ));
                                            },
                                            buttonWidth: 20.w,
                                            buttonHeight: 5.h,
                                          ),
                                          CustomButton(
                                            text: 'View team roles',
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      const ViewListDialog(
                                                        list: ['1', '2', '3'],
                                                        title:
                                                            'View team roles',
                                                      ));
                                            },
                                            buttonWidth: 20.w,
                                            buttonHeight: 5.h,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      CustomTextContainer(
                                          text:
                                              'descriptiodddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddn'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: 'View Members',
                      onPressed: () {},
                    ),
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
