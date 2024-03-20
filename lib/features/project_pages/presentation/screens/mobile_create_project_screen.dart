import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/core/util/snack_bar.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:team_finder_app/features/project_pages/presentation/providers/create_project_provider.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_dropdown_button.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/date_picker.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/team_roles_dialog.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/technologies_dialog_button.dart';

class MobileCreateProjectScreen extends StatelessWidget {
  const MobileCreateProjectScreen({
    super.key,
    required this.userId,
    required this.nameColtroler,
    required this.descriptionColtroler,
  });

  final String userId;
  final TextEditingController nameColtroler;
  final TextEditingController descriptionColtroler;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.goNamed(AppRouterConst.projectsMainScreen,
                pathParameters: {'userId': userId}),
          ),
          centerTitle: true,
          title: Text(
            'Create project',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Sizer(
          builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Consumer<CreateProjectProvider>(
                  builder: (_, provider, __) {
                    if (provider.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Expanded(
                          child: Card(
                            color:
                                Theme.of(context).colorScheme.surfaceContainer,
                            child: SingleChildScrollView(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTextField(
                                            nameConttroler: nameColtroler,
                                            hintText: 'Name',
                                            width: 90.w,
                                            onSubmitted: (String s) {},
                                          ),
                                          const SizedBox(height: 20),
                                          Text('Project period',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall),
                                          CustomDropdownButton(
                                            elements: [
                                              ProjectPeriod.fixed
                                                  .toStringValue(),
                                              ProjectPeriod.ongoing
                                                  .toStringValue()
                                            ],
                                            buttonWidth: 80.w,
                                            onChanged: (String? value) {
                                              provider.setPeriod(
                                                  ProjectPeriodX.fromString(
                                                      value!));
                                            },
                                            dropdownValue: provider.getPeriod
                                                .toStringValue(),
                                          ),
                                          const SizedBox(height: 20),
                                          Text('Project Status',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall),
                                          const SizedBox(height: 20),
                                          CustomDropdownButton(
                                            elements: [
                                              ProjectStatus.notStarted
                                                  .toStringValue(),
                                              ProjectStatus.starting
                                                  .toStringValue(),
                                            ],
                                            buttonWidth: 80.w,
                                            onChanged: (String? value) {
                                              provider.setStatus(
                                                  ProjectStatusX.fromString(
                                                      value!));
                                            },
                                            dropdownValue: provider.getStatus
                                                .toStringValue(),
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('Start Date',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall),
                                              MyDatePickerWidget(
                                                datePicked:
                                                    provider.getStartDate,
                                                function: (newValue) {
                                                  provider
                                                      .setStartDate(newValue);
                                                },
                                              ),
                                              SizedBox(width: 10.w),
                                              Text('End Date',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall),
                                              MyDatePickerWidget(
                                                datePicked:
                                                    provider.getDeadlineDate,
                                                function: (newValue) {
                                                  provider.setDeadlineDate(
                                                      newValue);
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              CustomButton(
                                                text: 'Add tehnologies',
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (ctx) => Consumer<
                                                        CreateProjectProvider>(
                                                      builder: (BuildContext
                                                                  context,
                                                              value,
                                                              Widget? child) =>
                                                          TechnologiesDialog(
                                                        onSubmitted:
                                                            (String s) {
                                                          value
                                                              .addTechnology(s);
                                                        },
                                                        onDissmised:
                                                            (int index) {
                                                          value.removeTechnology(
                                                              value.getTechnologyStack[
                                                                  index]);
                                                        },
                                                        name:
                                                            'Add technologies',
                                                        items: value
                                                            .getTechnologyStack,
                                                        sugestions:
                                                            value.sugestions,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                buttonWidth: 20.w,
                                                buttonHeight: 5.h,
                                              ),
                                              CustomButton(
                                                text: 'Add team roles',
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (ctx) => Consumer<
                                                        CreateProjectProvider>(
                                                      builder: (BuildContext
                                                                  context,
                                                              CreateProjectProvider
                                                                  value,
                                                              Widget? child) =>
                                                          TeamRolesDialog(
                                                        title: 'Add team roles',
                                                        description:
                                                            '   In this screen you shall be able to add team roles to your project. You can add as many as you want.',
                                                        items:
                                                            value.teamRoles.map(
                                                          (key, value) {
                                                            return MapEntry({
                                                              key.keys.first
                                                                      .name:
                                                                  key.values
                                                                      .first
                                                            }, value);
                                                          },
                                                        ),
                                                        onChanged: (bool? b,
                                                            int index,
                                                            int number) {
                                                          value.setTeamRoles(
                                                              index,
                                                              b!,
                                                              number);
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                },
                                                buttonWidth: 20.w,
                                                buttonHeight: 5.h,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          CustomTextField(
                                            nameConttroler:
                                                descriptionColtroler,
                                            hintText: "description",
                                            keyboardType:
                                                TextInputType.multiline,
                                            minLines: 10,
                                            width: 90.w,
                                            onSubmitted: (String s) {},
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          text: 'Done',
                          onPressed: () async {
                            provider.setDescription(descriptionColtroler.text);
                            provider.setName(nameColtroler.text);

                            (await context
                                    .read<CreateProjectProvider>()
                                    .createProject())
                                .fold(
                              (l) {
                                showSnackBar(context, l.message);
                              },
                              (r) {
                                showSnackBar(context, 'Project created');
                                context.goNamed(
                                    AppRouterConst.projectsMainScreen,
                                    pathParameters: {'userId': userId});
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
