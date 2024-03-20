import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';
import 'package:team_finder_app/features/project_pages/presentation/bloc/projects_bloc.dart';
import 'package:team_finder_app/features/project_pages/presentation/providers/edit_project_provider.dart';
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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<EditProjectProvider>(context, listen: false)
          .getTeamRoles();

      await Provider.of<EditProjectProvider>(context, listen: false)
          .fetchTechnologyStack();

      Provider.of<EditProjectProvider>(context, listen: false)
          .fillForm(widget.project);
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
    return Consumer<EditProjectProvider>(builder: (context, provider, child) {
      if (provider.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            actions: [
              ProjectStatusX.fromString(widget.project.status)
                      .isNotStartedOrStarting()
                  ? IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.black,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                    title: const Text('Delete project'),
                                    content: const Text(
                                        'Are you sure you want to delete this project?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          provider
                                              .deleteProject(widget.project.id);
                                          Navigator.of(context).pop();
                                          context.read<ProjectsBloc>().add(
                                              const GetActiveProjectPages());
                                          context.goNamed(
                                              AppRouterConst.projectsMainScreen,
                                              pathParameters: {
                                                'userId': widget.userId
                                              });
                                        },
                                        child: const Text("Yes"),
                                      )
                                    ]));
                      })
                  : Container(),
            ],
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
                                          onSubmitted: (String s) {
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
                                              provider.setPeriod(
                                                  ProjectPeriodX.fromString(
                                                      value!));
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
                                              provider.setStatus(
                                                  ProjectStatusX.fromString(
                                                      value!));
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
                                                provider.setStartDate(newValue);
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
                                                provider
                                                    .setDeadlineDate(newValue);
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
                                                            EditProjectProvider>(
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
                                                  builder: (context) =>
                                                      Consumer<
                                                          EditProjectProvider>(
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
                          provider.setName(nameColtroler.text);
                          provider.setDescription(descriptionColtroler.text);

                          provider.editProject(widget.projectId);
                          context.goNamed(AppRouterConst.projectsMainScreen,
                              pathParameters: {'userId': widget.userId});
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
      );
    });
  }
}
