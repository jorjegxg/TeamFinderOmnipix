import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/employee_pages/presentation/pages/employee_profile_page.dart';
import 'package:team_finder_app/features/employee_pages/presentation/provider/employee_roles_provider.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';
import 'package:team_finder_app/features/project_pages/presentation/pages/main_project_page.dart';
import 'package:team_finder_app/features/project_pages/presentation/providers/project_members_provider.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_icon_button.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/dealocation_dialog_widget.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/project_member_card.dart';
import 'package:team_finder_app/injection.dart';

class ProjectMembersPage extends StatelessWidget {
  const ProjectMembersPage({
    super.key,
    required this.projectId,
    required this.userId,
    required this.project,
  });
  final String projectId;
  final String userId;
  final ProjectEntity project;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          getIt<ProjectMembersProvider>()..getActiveMembers(projectId),
      child: Builder(builder: (context) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            floatingActionButton: Consumer<EmployeeRolesProvider>(
              builder: (context, value, child) => value.isProjectManager
                  ? FloatingActionButton(
                      child: const Icon(Icons.add, color: Colors.black),
                      onPressed: () {
                        context.goNamed(
                          AppRouterConst.addProjectMember,
                          pathParameters: {
                            'projectId': projectId,
                            'userId': userId
                          },
                          extra: project,
                        );
                      },
                    )
                  : const SizedBox.shrink(),
            ),
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Project Members',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: Consumer<ProjectMembersProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (provider.error != null) {
                  return Center(
                    child: Text(provider.error!),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    if (provider.getIsSelected[0]) {
                      provider.getPastMembers(projectId);
                    } else if (provider.getIsSelected[1]) {
                      provider.getActiveMembers(projectId);
                    } else {
                      provider.getFutureMembers(projectId);
                    }
                  },
                  child: Sizer(
                    builder: (BuildContext context, Orientation orientation,
                        DeviceType deviceType) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  //TODO: add functionality to the icon buttons,the selected icon should be highlighted
                                  CustomIconButton(
                                    icon: Icons.person_off,
                                    onPressed: () {
                                      provider.setIsSelected(0);

                                      provider.getPastMembers(projectId);
                                    },
                                    iconColor: provider.getIsSelected[0]
                                        ? const Color(0xFF0d1290)
                                        : Theme.of(context).colorScheme.surface,
                                  ),
                                  CustomIconButton(
                                    icon: Icons.person,
                                    onPressed: () {
                                      provider.setIsSelected(1);

                                      provider.getActiveMembers(projectId);
                                    },
                                    iconColor: provider.getIsSelected[1]
                                        ? const Color(0xFF0d1290)
                                        : Theme.of(context).colorScheme.surface,
                                  ),
                                  CustomIconButton(
                                    icon: Icons.person_add,
                                    onPressed: () {
                                      provider.setIsSelected(2);

                                      provider.getFutureMembers(projectId);
                                    },
                                    iconColor: provider.getIsSelected[2]
                                        ? Colors.black
                                        : Theme.of(context).colorScheme.surface,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Expanded(
                                child: Card(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainer,
                                  child: provider.getSelectedMembers().isEmpty
                                      ? const NotFoundWidget(
                                          text: 'No members found',
                                        )
                                      : ListView.builder(
                                          itemCount: provider
                                              .getSelectedMembers()
                                              .length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: ProjectMemberCard(
                                                name: provider
                                                    .getSelectedMembers()[index]
                                                    .name,
                                                //make string form list
                                                email: provider
                                                    .getSelectedMembers()[index]
                                                    .teamRoles
                                                    .map((e) => e.name)
                                                    .join(', '),
                                                onPressed: (BuildContext ctx) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (ctx) =>
                                                          DealocationDialog(
                                                            projectId:
                                                                projectId,
                                                            employeeId: provider
                                                                .getSelectedMembers()[
                                                                    index]
                                                                .id,
                                                          ));
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                ),
                              ),
                              const SizedBox(height: 60),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
