import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/core/util/snack_bar.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:team_finder_app/features/project_pages/presentation/providers/create_project_provider.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_dropdown_button.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/date_picker.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/item_with_checkbox.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/suggestion_text_field.dart';

class DesktopCreateProjectScreen extends HookWidget {
  const DesktopCreateProjectScreen({
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
    final ScrollController scrollControler1 = useScrollController();
    final ScrollController scrollControler2 = useScrollController();
    final TextEditingController techController = useTextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Create project',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Sizer(
          builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                margin: const EdgeInsets.all(20),
                color: Theme.of(context).colorScheme.surfaceContainer,
                child: Consumer<CreateProjectProvider>(
                  builder: (context, provider, child) => provider.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 300,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w, vertical: 10),
                                            child: Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text('Name:',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall),
                                                    Text('Project period:',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall),
                                                    Text('Project Status:',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall),
                                                  ],
                                                ),
                                                SizedBox(width: 5.w),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    CustomTextField(
                                                      nameConttroler:
                                                          nameColtroler,
                                                      hintText: 'Name',
                                                      width: 20.w,
                                                    ),
                                                    CustomDropdownButton(
                                                      elements: [
                                                        ProjectPeriod.fixed
                                                            .toStringValue(),
                                                        ProjectPeriod.ongoing
                                                            .toStringValue()
                                                      ],
                                                      buttonWidth: 20.w,
                                                      onChanged:
                                                          (String? value) {
                                                        provider.setPeriod(
                                                            ProjectPeriodX
                                                                .fromString(
                                                                    value!));
                                                      },
                                                      dropdownValue: provider
                                                          .getPeriod
                                                          .toStringValue(),
                                                    ),
                                                    CustomDropdownButton(
                                                      elements: [
                                                        ProjectStatus.NotStarted
                                                            .toStringValue(),
                                                        ProjectStatus.Starting
                                                            .toStringValue(),
                                                      ],
                                                      buttonWidth: 20.w,
                                                      onChanged:
                                                          (String? value) {
                                                        provider.setStatus(
                                                            ProjectStatusX
                                                                .fromString(
                                                                    value!));
                                                      },
                                                      dropdownValue: provider
                                                          .getStatus
                                                          .toStringValue(),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.5.w),
                                            child: SizedBox(
                                              width: getValueForScreenType(
                                                  context: context,
                                                  mobile: 50.w,
                                                  tablet: 35.w,
                                                  desktop: 25.w),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text('Start Date',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall),
                                                      MyDatePickerWidget(
                                                        datePicked: provider
                                                            .getStartDate,
                                                        function: (newValue) {
                                                          provider.setStartDate(
                                                              newValue);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text('End Date',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall),
                                                      MyDatePickerWidget(
                                                        datePicked: provider
                                                            .getDeadlineDate,
                                                        function: (newValue) {
                                                          provider
                                                              .setDeadlineDate(
                                                                  newValue);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 40),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 7.5.w),
                                            child: CustomTextField(
                                              nameConttroler:
                                                  descriptionColtroler,
                                              hintText: "description",
                                              keyboardType:
                                                  TextInputType.multiline,
                                              minLines: 10,
                                              width: 30.w,
                                            ),
                                          ),
                                          const SizedBox(height: 40),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const SizedBox(height: 20),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.5.w,
                                                vertical: 10),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Add technologies',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                                const SizedBox(height: 15),
                                                SuggestionTextField(
                                                  width: 20.w,
                                                  options: provider.sugestions
                                                      .map((e) => e.name)
                                                      .toList(),
                                                  onSubmitted: (String s) {
                                                    provider.addTechnology(s);
                                                    techController.clear();
                                                  },
                                                  controller: techController,
                                                ),
                                                const SizedBox(height: 15),
                                                ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxWidth: 20.w,
                                                      maxHeight: 200),
                                                  child:
                                                      DraggableScrollbar.rrect(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                    alwaysVisibleScrollThumb:
                                                        true,
                                                    controller:
                                                        scrollControler1,
                                                    child: ListView.builder(
                                                        controller:
                                                            scrollControler1,
                                                        itemCount: provider
                                                            .getTechnologyStack
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Dismissible(
                                                            key: UniqueKey(),
                                                            movementDuration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        400),
                                                            onDismissed:
                                                                (direction) {
                                                              provider.removeTechnology(
                                                                  provider.getTechnologyStack[
                                                                      index]);
                                                            },
                                                            child: ListTile(
                                                              title: Text(
                                                                provider
                                                                    .getTechnologyStack[
                                                                        index]
                                                                    .name,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium,
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w),
                                            child: const Divider(),
                                          ),
                                          const SizedBox(height: 10),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.5.w,
                                                vertical: 10),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Add team roles',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                                const SizedBox(height: 15),
                                                ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxHeight: 200,
                                                      maxWidth: 20.w),
                                                  child:
                                                      DraggableScrollbar.rrect(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                    alwaysVisibleScrollThumb:
                                                        true,
                                                    controller:
                                                        scrollControler2,
                                                    child: ListView.builder(
                                                      controller:
                                                          scrollControler2,
                                                      itemCount: provider
                                                          .teamRoles.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return ItemWithCheckBox(
                                                          text: provider
                                                              .getNameFromTeamRole(
                                                                  index),
                                                          onChanged: (bool? b,
                                                              int number) {
                                                            provider
                                                                .setTeamRoles(
                                                                    index,
                                                                    b!,
                                                                    number);
                                                          },
                                                          value: provider
                                                              .teamRoles.values
                                                              .elementAt(index),
                                                          enabled: false,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                              child: CustomButton(
                                text: 'Done',
                                onPressed: () async {
                                  provider.setDescription(
                                      descriptionColtroler.text);
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
                            ),
                            const SizedBox(height: 20),
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
