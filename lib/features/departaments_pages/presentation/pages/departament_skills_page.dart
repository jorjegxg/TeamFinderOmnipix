import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/choice_dialog.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/skill_card.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/team_roles_dialog.dart';

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
    List<String> items = List.generate(10, (index) => 'Item $index');
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
                          items: const [
                            'Item 1',
                            'Item 2',
                            'Item 3',
                            'Item 4',
                            'Item 5',
                            'Item 6',
                            'Item 7',
                            'Item 8',
                            'Item 9',
                            'Item 10'
                          ],
                          onChanged: (bool? b) {
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
                      child: GridView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return SkillCard(
                            onPressed: (BuildContext ctx) {},
                            skillName: 'Skill Name',
                            skillDescription: 'Skill Description',
                            skillAuthor: 'Skill Author',
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 40.h,
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
  }
}
