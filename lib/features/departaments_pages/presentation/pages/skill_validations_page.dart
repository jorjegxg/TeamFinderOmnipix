import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/validations_provider.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/requests_card.dart';
import 'package:team_finder_app/injection.dart';

class SkillValidationPage extends HookWidget {
  const SkillValidationPage({
    super.key,
    required this.userId,
    required this.departamentId,
  });
  final String userId;
  final String departamentId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          getIt<ValidationProvider>()..fetchValidations(departamentId),
      child: Builder(builder: (context) {
        return Consumer<ValidationProvider>(
          builder: (_, provider, __) => SafeArea(
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'Skill Validations',
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
                            child: ListView.builder(
                              itemCount: provider.allItems.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: RequestsCard(
                                    mainTitle:
                                        provider.allItems[index].employeeName,
                                    text1:
                                        'Skill: ${provider.allItems[index].skill.name}',
                                    text2:
                                        'Level: ${provider.allItems[index].level}',
                                    text3:
                                        'Experience: ${ExperienceLevel.values[provider.allItems[index].experience].toStringValue()}',
                                    onRefuse: () {
                                      provider.refuseValidation(
                                          provider.allItems[index].id);
                                    },
                                    onAccept: () {
                                      provider.acceptValidation(
                                          provider.allItems[index].id);
                                    },
                                  ),
                                );
                              },
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
          ),
        );
      }),
    );
  }
}
