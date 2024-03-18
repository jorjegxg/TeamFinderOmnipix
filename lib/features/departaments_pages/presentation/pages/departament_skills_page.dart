import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departament_skills_provider.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/choice_dialog.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/skill_card.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/item_with_checkbox.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/team_roles_dialog.dart';
import 'package:team_finder_app/injection.dart';

class DepartmentSkillsPage extends StatefulWidget {
  const DepartmentSkillsPage({
    super.key,
    required this.userId,
    required this.departamentId,
  });
  final String userId;
  final String departamentId;

  @override
  State<DepartmentSkillsPage> createState() => _DepartmentSkillsPageState();
}

class _DepartmentSkillsPageState extends State<DepartmentSkillsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<DepartamentSkillsProvider>(context, listen: false)
          .fetchSkillsForDepartament(widget.departamentId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Departament Skills',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        floatingActionButton: Consumer<DepartamentSkillsProvider>(
          builder: (context, value, child) => FloatingActionButton(
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return ChoiceDialog(
                      chooseSkillPress: () async {
                        await value
                            .fetchSkillsNotInDepartament(widget.departamentId);
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (context) => ChooseSkill(
                                  departamentId: widget.departamentId,
                                ));
                      },
                      createSkillPress: () {
                        Navigator.of(context).pop();
                        context.goNamed(
                          AppRouterConst.createSkillPage,
                          pathParameters: {
                            'departamentId': widget.departamentId,
                            'userId': widget.userId
                          },
                        );
                      },
                    );
                  });
            },
            child: const Icon(Icons.add, color: Colors.black),
          ),
        ),
        body: Sizer(
          builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) {
            return RefreshIndicator(
              onRefresh: () async {
                await Provider.of<DepartamentSkillsProvider>(context,
                        listen: false)
                    .fetchSkillsForDepartament(widget.departamentId);
              },
              child: Center(
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
                                skillAuthor: provider.skills[index].description,
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
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChooseSkill extends StatelessWidget {
  const ChooseSkill({
    super.key,
    required this.departamentId,
  });
  final String departamentId;

  @override
  Widget build(BuildContext context) {
    return Consumer<DepartamentSkillsProvider>(
      builder: (context, value, child) => Dialog(
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
                    itemCount: value.skillsNotInDepartament.length,
                    itemBuilder: (context, index) {
                      return ItemWithCheckBox(
                        value: value.skillsNotInDepartament.values
                            .elementAt(index),
                        text: value.skillsNotInDepartament.keys
                            .elementAt(index)
                            .name,
                        onChanged: (bool? bool, int number) {
                          value.setSkillBool(
                              value.skillsNotInDepartament.keys
                                  .elementAt(index),
                              bool!);
                        },
                        enabled: false,
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
                    onPressed: () {
                      value.addSelectedSkillsToDepartament(departamentId);
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
  }
}
