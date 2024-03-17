import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departament_skills_provider.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/choice_dialog.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/skill_card.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/team_roles_dialog.dart';
import 'package:team_finder_app/injection.dart';

class DepartmentSkillsPage extends HookWidget {
  const DepartmentSkillsPage({
    super.key,
    required this.userId,
    required this.departamentId,
  });
  final String userId;
  final String departamentId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<DepartamentSkillsProvider>()
        ..fetchSkillsForDepartament(departamentId),
      child: Builder(builder: (context) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Departament Skills',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) {
                      return ChoiceDialog(
                        chooseSkillPress: () {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) => TeamRolesDialog(
                              title: 'Add a skill',
                              description:
                                  'You can choose any skills from the list',
                              items: {},
                              onChanged: (bool? b, index, int number) {
                                //IMplement the onChanged function
                              },
                            ),
                          );
                        },
                        createSkillPress: () {
                          Navigator.of(context).pop();
                          context.goNamed(
                            AppRouterConst.createSkillPage,
                            pathParameters: {
                              'departamentId': departamentId,
                              'userId': userId
                            },
                          );
                        },
                      );
                    });
              },
              child: const Icon(Icons.add, color: Colors.black),
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
                          child: Consumer<DepartamentSkillsProvider>(
                            builder: (BuildContext context,
                                    DepartamentSkillsProvider provider,
                                    Widget? child) =>
                                GridView.builder(
                              itemCount: provider.skills.length,
                              itemBuilder: (context, index) {
                                return SkillCard(
                                  onPressed: (BuildContext ctx) {},
                                  skillName: provider.skills[index].name,
                                  skillDescription:
                                      provider.skills[index].category,
                                  skillAuthor:
                                      provider.skills[index].description,
                                );
                              },
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 40.h,
                              ),
                            ),
                          ),
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
      }),
    );
  }
}
