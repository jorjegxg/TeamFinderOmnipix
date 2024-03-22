import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/project_details_body.dart';

class ProjectInactiveDetailsScreen extends HookWidget {
  const ProjectInactiveDetailsScreen({
    required this.userId,
    super.key,
    required this.projectId,
  });

  final String userId;
  final String projectId;

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
        body: ValueListenableBuilder(
          valueListenable:
              Hive.box<ProjectEntity>(HiveConstants.projectEntityBox)
                  .listenable(),
          builder: (context, box, child) => Sizer(
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
                              project: box.values.firstWhere(
                                (element) => element.id == projectId,
                              ),
                            );
                          },
                          desktop: (context) {
                            return DesktopProjectDetailsScreen(
                              project: box.values.firstWhere(
                                (element) => element.id == projectId,
                              ),
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
      ),
    );
  }
}
