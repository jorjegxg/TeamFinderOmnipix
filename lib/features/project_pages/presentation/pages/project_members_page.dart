import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_icon_button.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/dealocation_dialog_widget.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/project_member_card.dart';

class ProjectMembersPage extends StatefulWidget {
  const ProjectMembersPage({
    super.key,
    required this.projectId,
  });
  final String projectId;

  @override
  State<ProjectMembersPage> createState() => _ProjectMembersPageState();
}

class _ProjectMembersPageState extends State<ProjectMembersPage> {
  List<String> items = List.generate(10, (index) => 'Item $index');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, color: Colors.black),
          onPressed: () {
            context.goNamed(
              AppRouterConst.addProjectMember,
              pathParameters: {'projectId': widget.projectId},
            );
          },
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.goNamed(AppRouterConst.projectsMainScreen),
          ),
          centerTitle: true,
          title: Text(
            'Project Members',
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
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //TODO: add functionality to the icon buttons,the selected icon should be highlighted
                        CustomIconButton(
                          icon: Icons.person_off,
                          onPressed: () {},
                          iconColor: Theme.of(context).colorScheme.surface,
                        ),
                        CustomIconButton(
                          icon: Icons.person,
                          onPressed: () {},
                          iconColor: Color(0xFF0d1290),
                        ),
                        CustomIconButton(
                          icon: Icons.person_add,
                          onPressed: () {},
                          iconColor: Theme.of(context).colorScheme.surface,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Card(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: ProjectMemberCard(
                                name: 'name',
                                email: 'email',
                                onPressed: (BuildContext ctx) {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) =>
                                          const DealocationDialog());
                                  setState(() {
                                    items.removeAt(index);
                                  });
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
      ),
    );
  }
}
