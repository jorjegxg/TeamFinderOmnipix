import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';
import 'package:team_finder_app/features/project_pages/presentation/bloc/create_project_provider.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_dropdown_button.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/date_picker.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/team_roles_dialog.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/technologies_dialog_button.dart';

class EditProjectScreen extends StatefulWidget {
  const EditProjectScreen({
    super.key,
    required this.projectId,
    required this.userId,
    required this.project,
  });
  final String projectId;
  final String userId;
  final ProjectEntity project;

  @override
  State<EditProjectScreen> createState() => _EditProjectScreenState();
}

class _EditProjectScreenState extends State<EditProjectScreen> {
  final nameColtroler = TextEditingController();
  final descriptionColtroler = TextEditingController();

  //TODO: implement edit project to have preexisting data

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CreateProjectProvider>(context, listen: false)
        ..getTeamRoles()
        ..fillForm(widget.project);
      nameColtroler.text = widget.project.name;
      descriptionColtroler.text = widget.project.description;
    });

    super.initState();
  }

  @override
  void dispose() {
    nameColtroler.dispose();
    descriptionColtroler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateProjectProvider>(
      builder: (context, provider, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => context.goNamed(
                  AppRouterConst.projectsMainScreen,
                  pathParameters: {'userId': widget.userId}),
            ),
            centerTitle: true,
            title: Text(
              'Edit project',
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
                        child: Card(
                          color: Theme.of(context).colorScheme.surfaceContainer,
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
                                          onSubmitted: (String) {
                                            //TODO: implement onSubmitted logic
                                          },
                                        ),
                                        const SizedBox(height: 20),
                                        Text('Project period',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall),
                                        Center(
                                          child: CustomDropdownButton(
                                            elements: [
                                              ProjectPeriod.fixed
                                                  .toStringValue(),
                                              ProjectPeriod.ongoing
                                                  .toStringValue()
                                            ],
                                            buttonWidth: 80.w,
                                            onChanged: (String? value) {
                                              //TODO: implement onChanged logic
                                            },
                                            dropdownValue: provider.getPeriod
                                                .toStringValue(),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Text('Project Status',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall),
                                        const SizedBox(height: 20),
                                        Center(
                                          child: CustomDropdownButton(
                                            elements: [
                                              ProjectStatus.NotStarted
                                                  .toStringValue(),
                                              ProjectStatus.Starting
                                                  .toStringValue(),
                                              ProjectStatus.InProgress
                                                  .toStringValue(),
                                              ProjectStatus.Closing
                                                  .toStringValue(),
                                              ProjectStatus.Closed
                                                  .toStringValue(),
                                            ],
                                            buttonWidth: 80.w,
                                            onChanged: (String? value) {
                                              //TODO: implement onChanged logic
                                            },
                                            dropdownValue: provider.getStatus
                                                .toStringValue(),
                                          ),
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
                                              datePicked: provider.getStartDate,
                                              function: (newValue) {
                                                //TODO: implement date logic
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
                                                //TODO: implement date logic
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
                                                    builder: (context) =>
                                                        Consumer<
                                                            CreateProjectProvider>(
                                                          builder: (context,
                                                                  provider,
                                                                  _) =>
                                                              TechnologiesDialog(
                                                            onSubmitted:
                                                                (String s) {
                                                              provider
                                                                  .addTechnology(
                                                                      s);
                                                            },
                                                            onDissmised:
                                                                (int index) {
                                                              provider.removeTechnology(
                                                                  provider.getTechnologyStack[
                                                                      index]);
                                                            },
                                                            name: '',
                                                            items: provider
                                                                .getTechnologyStack,
                                                            sugestions: provider
                                                                .sugestions,
                                                          ),
                                                        ));
                                              },
                                              buttonWidth: 20.w,
                                              buttonHeight: 5.h,
                                            ),
                                            CustomButton(
                                              text: 'Add team roles',
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) => Consumer<
                                                      CreateProjectProvider>(
                                                    builder: (context, provider,
                                                            _) =>
                                                        TeamRolesDialog(
                                                      title: 'Add team roles',
                                                      description:
                                                          '   In this screen you shall be able to add team roles to your project. You can add as many as you want.',
                                                      items: provider
                                                          .getteamRoles
                                                          .map(
                                                        (key, value) {
                                                          return MapEntry({
                                                            key.keys.first.name:
                                                                key.values.first
                                                          }, value);
                                                        },
                                                      ),
                                                      onChanged: (bool? b,
                                                          index, int number) {
                                                        provider.setTeamRoles(
                                                            index, b!, number);
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
                                          nameConttroler: descriptionColtroler,
                                          hintText: "description",
                                          keyboardType: TextInputType.multiline,
                                          minLines: 10,
                                          width: 90.w,
                                          onSubmitted: (String s) {
                                            //TODO: implement onSubmitted logic
                                          },
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
                        onPressed: () {
                          //TODO: implement done logic
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
