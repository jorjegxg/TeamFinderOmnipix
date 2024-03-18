import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/skill_card.dart';
import 'package:team_finder_app/features/settings/presentation/providers/personal_skills_provider.dart';
import 'package:team_finder_app/injection.dart';

class PersonalSkillsPage extends HookWidget {
  const PersonalSkillsPage({
    super.key,
    required this.userId,
  });
  final String userId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          getIt<PersonalSkillsProvider>()..fetchSkillsForEmployee(userId),
      child: Builder(builder: (context) {
        return RefreshIndicator(
          onRefresh: () async {
            context
                .read<PersonalSkillsProvider>()
                .fetchSkillsForEmployee(userId);
          },
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'Personal Skills',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  context.goNamed(AppRouterConst.addSkillPage,
                      pathParameters: {'userId': userId});
                },
                child: const Icon(Icons.add, color: Colors.black),
              ),
              body: Sizer(
                builder: (BuildContext context, Orientation orientation,
                    DeviceType deviceType) {
                  return Center(
                    child: Consumer<PersonalSkillsProvider>(
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
                                      onPressed: (BuildContext ctx) {},
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
