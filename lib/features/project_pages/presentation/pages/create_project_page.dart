import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_dropdown_button.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/date_picker.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/team_roles_dialog.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/technologies_dialog_button.dart';

enum ProjectPeriod { fixed, ongoing }

class CreateProjectScreen extends HookWidget {
  const CreateProjectScreen({super.key, required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context) {
    final nameColtroler = useTextEditingController();
    final descriptionColtroler = useTextEditingController();
    return SafeArea(
      child: Scaffold(
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
                                      CustomDropdownButton(
                                        elements: const ['Fixed', 'Ongoing'],
                                        buttonWidth: 80.w,
                                        onChanged: (String? value) {
                                          //TODO: implement onChanged logic
                                        },
                                        dropdownValue: 'Fixed',
                                      ),
                                      const SizedBox(height: 20),
                                      Text('Project Status',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall),
                                      const SizedBox(height: 20),
                                      CustomDropdownButton(
                                        elements: const [
                                          'Not Started',
                                          'Starting',
                                        ],
                                        buttonWidth: 80.w,
                                        onChanged: (String? value) {
                                          //TODO: implement onChanged logic
                                        },
                                        dropdownValue: 'Not Started',
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
                                            datePicked: DateTime.now(),
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
                                            datePicked: DateTime.now(),
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
                                                      const TechnologiesDialog());
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
                                                    TeamRolesDialog(
                                                  title: 'Add team roles',
                                                  description:
                                                      '   In this screen you shall be able to add team roles to your project. You can add as many as you want.',
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
    );
  }
}
