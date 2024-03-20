import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/project_details_body.dart';

class ProjectInactiveDetailsScreen extends HookWidget {
  const ProjectInactiveDetailsScreen(
      {required this.userId, super.key, required this.project});

  final String userId;
  final ProjectEntity project;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
