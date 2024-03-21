import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/core/util/snack_bar.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_dropdown_button.dart';
import 'package:team_finder_app/features/settings/presentation/providers/add_skill_provider.dart';
import 'package:team_finder_app/injection.dart';

class DirectSkillPage extends HookWidget {
  const DirectSkillPage({
    super.key,
    required this.userId,
    required this.departamentId,
    required this.departamentName,
  });
  final String userId;
  final String departamentId;
  final String departamentName;
  @override
  Widget build(BuildContext context) {
    final nameColtroler = useTextEditingController();
    final descriptionColtroler = useTextEditingController();
    return ChangeNotifierProvider(
      create: (context) =>
          getIt<SkillAssignmentProvider>()..getFreeSkills(userId),
      child: Builder(builder: (context) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Add Skill',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: Sizer(
              builder: (BuildContext context, Orientation orientation,
                  DeviceType deviceType) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Consumer(
                      builder: (context,
                          SkillAssignmentProvider skillAssignmentProvider,
                          child) {
                        return skillAssignmentProvider.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : skillAssignmentProvider.error != null
                                ? Center(
                                    child: Text(
                                      skillAssignmentProvider.error!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  )
                                : skillAssignmentProvider.skills.isEmpty
                                    ? Center(
                                        child: Text(
                                          'No skills in organization',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                      )
                                    : BodyWidget(
                                        nameColtroler: nameColtroler,
                                        descriptionColtroler:
                                            descriptionColtroler,
                                        userId: userId,
                                        departamentId: departamentId,
                                        departamentName: departamentName,
                                      );
                      },
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

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    super.key,
    required this.nameColtroler,
    required this.descriptionColtroler,
    required this.userId,
    required this.departamentId,
    required this.departamentName,
  });

  final TextEditingController nameColtroler;
  final TextEditingController descriptionColtroler;

  final String userId;
  final String departamentId;
  final String departamentName;

  @override
  Widget build(BuildContext context) => Consumer(builder:
          (context, SkillAssignmentProvider skillAssignmentProvider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Card(
                color: Theme.of(context).colorScheme.surfaceContainer,
                child: SingleChildScrollView(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              CustomDropdownButton(
                                elements: skillAssignmentProvider.skills
                                    .map((e) => e.name)
                                    .toList(),
                                buttonWidth: 80.w,
                                onChanged: (String? value) {
                                  skillAssignmentProvider
                                      .setSelectedSkill(value!);
                                },
                                dropdownValue:
                                    skillAssignmentProvider.selectedSkill!.name,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomDropdownButton(
                                elements: [
                                  SkillLevel.learns.toStringValue(),
                                  SkillLevel.knows.toStringValue(),
                                  SkillLevel.does.toStringValue(),
                                  SkillLevel.helps.toStringValue(),
                                  SkillLevel.teaches.toStringValue(),
                                ],
                                buttonWidth: 80.w,
                                onChanged: (String? value) {
                                  skillAssignmentProvider.skillLevel =
                                      SkillLevelX.fromString(value!);
                                },
                                dropdownValue: skillAssignmentProvider
                                    .skillLevel
                                    .toStringValue(),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomDropdownButton(
                                elements: [
                                  ExperienceLevel.months0_6.toStringValue(),
                                  ExperienceLevel.months6_12.toStringValue(),
                                  ExperienceLevel.years1_2.toStringValue(),
                                  ExperienceLevel.years2_4.toStringValue(),
                                  ExperienceLevel.years4_7.toStringValue(),
                                  ExperienceLevel.years7.toStringValue(),
                                ],
                                buttonWidth: 80.w,
                                onChanged: (String? value) {
                                  skillAssignmentProvider.setExperienceLevel =
                                      ExperienceLevelX.fromString(value!);
                                },
                                dropdownValue: skillAssignmentProvider
                                    .experienceLevel
                                    .toStringValue(),
                              ),
                              const Divider(),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Add',
              onPressed: () async {
                await skillAssignmentProvider.addSkillToEmployee(
                    context, userId, departamentId);
                if (!context.mounted) return;

                context.goNamed(AppRouterConst.departamentEmployeesPage,
                    pathParameters: {
                      'userId': userId,
                      'departamentId': departamentId,
                      'departamentName': departamentName
                    });
              },
            ),
            const SizedBox(height: 20),
          ],
        );
      });
}
