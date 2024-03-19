import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/skill_card.dart';
import 'package:team_finder_app/features/settings/presentation/providers/owned_skills_provider.dart';
import 'package:team_finder_app/injection.dart';

class OwnedSkillsPage extends HookWidget {
  const OwnedSkillsPage({
    super.key,
    required this.userId,
  });
  final String userId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<OwnedSkillsProvider>()..fetchOwnedSkills(),
      child: Builder(builder: (contextBuild) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Owned Skills',
                style: Theme.of(contextBuild).textTheme.titleLarge,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                contextBuild.goNamed(AppRouterConst.createSkillPage,
                    pathParameters: {'userId': userId});
              },
              child: const Icon(Icons.add, color: Colors.black),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                contextBuild.read<OwnedSkillsProvider>().fetchOwnedSkills();
              },
              child: Sizer(
                builder: (BuildContext context, Orientation orientation,
                    DeviceType deviceType) {
                  return Center(
                    child: Consumer<OwnedSkillsProvider>(
                      builder: (context, provider, child) {
                        if (provider.isLoading) {
                          return const CircularProgressIndicator();
                        }
                        if (provider.error != null) {
                          return Center(
                            child: Text(provider.error!),
                          );
                        }
                        if (provider.skills.isEmpty) {
                          return const Center(
                            child: Text('No skills added yet'),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              Expanded(
                                child: GridView.builder(
                                  itemCount: provider.skills.length,
                                  itemBuilder: (context, index) {
                                    return SkillCard(
                                      skillName: provider.skills[index].name,
                                      skillDescription:
                                          provider.skills[index].description,
                                      skillAuthor:
                                          provider.skills[index].category,
                                      onRemove: (BuildContext ctx) {
                                        showDialog(
                                          context: ctx,
                                          builder: (alertContext) =>
                                              AlertDialog(
                                            title: const Text('Are you sure?'),
                                            content: const Text(
                                                'Do you want to remove this skill?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(alertContext)
                                                      .pop();
                                                },
                                                child: const Text('No'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  await provider.deleteSkill(
                                                    provider.skills[index],
                                                    contextBuild,
                                                  );
                                                  if (!alertContext.mounted) {
                                                    return;
                                                  }
                                                  Navigator.of(alertContext)
                                                      .pop();
                                                },
                                                child: const Text('Yes'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 40.h,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
