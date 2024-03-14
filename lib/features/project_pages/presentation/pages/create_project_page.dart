import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_dropdown_button.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/date_picker.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/item_with_checkbox.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/suggestion_text_field.dart';
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
    return ScreenTypeLayout.builder(
      mobile: (context) {
        return MobileCreateProjectScreen(
            userId: userId,
            nameColtroler: nameColtroler,
            descriptionColtroler: descriptionColtroler);
      },
      tablet: (context) {
        return TabletCreateProjectScreen(
            userId: userId,
            nameColtroler: nameColtroler,
            descriptionColtroler: descriptionColtroler);
      },
      desktop: (context) {
        return DesktopCreateProjectScreen(
            userId: userId,
            nameColtroler: nameColtroler,
            descriptionColtroler: descriptionColtroler);
      },
    );
  }
}

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
    final ScrollController _scrollControler1 = useScrollController();
    final ScrollController _scrollControler2 = useScrollController();
    List<String> items = [
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
    ];
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 300,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 10),
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
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
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CustomTextField(
                                              nameConttroler: nameColtroler,
                                              hintText: 'Name',
                                              width: 20.w,
                                              onSubmitted: (String) {
                                                //TODO: implement onSubmitted logic
                                              },
                                            ),
                                            CustomDropdownButton(
                                              elements: const [
                                                'Fixed',
                                                'Ongoing'
                                              ],
                                              buttonWidth: 20.w,
                                              onChanged: (String? value) {
                                                //TODO: implement onChanged logic
                                              },
                                              dropdownValue: 'Fixed',
                                            ),
                                            CustomDropdownButton(
                                              elements: const [
                                                'Not Started',
                                                'Starting',
                                              ],
                                              buttonWidth: 20.w,
                                              onChanged: (String? value) {
                                                //TODO: implement onChanged logic
                                              },
                                              dropdownValue: 'Not Started',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.5.w),
                                    child: SizedBox(
                                      width: getValueForScreenType(
                                          context: context,
                                          mobile: 50.w,
                                          tablet: 35.w,
                                          desktop: 25.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
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
                                            ],
                                          ),
                                          Row(
                                            children: [
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
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 7.5.w),
                                    child: CustomTextField(
                                      nameConttroler: descriptionColtroler,
                                      hintText: "description",
                                      keyboardType: TextInputType.multiline,
                                      minLines: 10,
                                      width: 30.w,
                                      onSubmitted: (String s) {
                                        //TODO: implement onSubmitted logic
                                      },
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
                                        horizontal: 2.5.w, vertical: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10),
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
                                        SuggestionTextField(
                                          width: 20.w,
                                          options: const ['asdas'],
                                          onSubmitted: (String s) {
                                            //TODO: add functionality to the text field,add the text to the list
                                          },
                                          controller: nameColtroler,
                                        ),
                                        const SizedBox(height: 15),
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxWidth: 20.w, maxHeight: 200),
                                          child: DraggableScrollbar.rrect(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            alwaysVisibleScrollThumb: true,
                                            controller: _scrollControler1,
                                            child: ListView.builder(
                                                controller: _scrollControler1,
                                                itemCount: 10,
                                                itemBuilder: (context, index) {
                                                  return Slidable(
                                                    key: UniqueKey(),
                                                    startActionPane: ActionPane(
                                                      // A motion is a widget used to control how the pane animates.
                                                      motion:
                                                          const ScrollMotion(),

                                                      // A pane can dismiss the Slidable.
                                                      dismissible:
                                                          DismissiblePane(
                                                              onDismissed: () {
                                                        //TODO: implement onDismissed logic
                                                        items.removeAt(index);
                                                      }),

                                                      // All actions are defined in the children parameter.
                                                      children: [
                                                        // A SlidableAction can have an icon and/or a label.
                                                      ],
                                                    ),
                                                    child: ListTile(
                                                      title: Text(
                                                        'Item $index',
                                                        style: Theme.of(context)
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.w),
                                    child: const Divider(),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.5.w, vertical: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10),
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
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxHeight: 200, maxWidth: 20.w),
                                          child: DraggableScrollbar.rrect(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            alwaysVisibleScrollThumb: true,
                                            controller: _scrollControler2,
                                            child: ListView.builder(
                                              controller: _scrollControler2,
                                              itemCount: items.length,
                                              itemBuilder: (context, index) {
                                                return ItemWithCheckBox(
                                                  text: items[index],
                                                  onChanged: (bool? b) {},
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
                        onPressed: () {
                          //TODO: implement done logic
                        },
                      ),
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

class TabletCreateProjectScreen extends HookWidget {
  const TabletCreateProjectScreen({
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
    final ScrollController _scrollControler1 = useScrollController();
    final ScrollController _scrollControler2 = useScrollController();
    List<String> items = [
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
    ];
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 300,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
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
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CustomTextField(
                                            nameConttroler: nameColtroler,
                                            hintText: 'Name',
                                            width: 50.w,
                                            onSubmitted: (String) {
                                              //TODO: implement onSubmitted logic
                                            },
                                          ),
                                          CustomDropdownButton(
                                            elements: const [
                                              'Fixed',
                                              'Ongoing'
                                            ],
                                            buttonWidth: 50.w,
                                            onChanged: (String? value) {
                                              //TODO: implement onChanged logic
                                            },
                                            dropdownValue: 'Fixed',
                                          ),
                                          CustomDropdownButton(
                                            elements: const [
                                              'Not Started',
                                              'Starting',
                                            ],
                                            buttonWidth: 50.w,
                                            onChanged: (String? value) {
                                              //TODO: implement onChanged logic
                                            },
                                            dropdownValue: 'Not Started',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.5.w),
                                  child: SizedBox(
                                    width: getValueForScreenType(
                                        context: context,
                                        mobile: 50.w,
                                        tablet: 50.w,
                                        desktop: 25.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
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
                                          ],
                                        ),
                                        Row(
                                          children: [
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
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 40),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 7.5.w),
                                  child: CustomTextField(
                                    nameConttroler: descriptionColtroler,
                                    hintText: "description",
                                    keyboardType: TextInputType.multiline,
                                    minLines: 10,
                                    width: 50.w,
                                    onSubmitted: (String s) {
                                      //TODO: implement onSubmitted logic
                                    },
                                  ),
                                ),
                                const SizedBox(height: 40),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.5.w, vertical: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Add team roles',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      const SizedBox(height: 15),
                                      SuggestionTextField(
                                        width: 50.w,
                                        options: const ['asdas'],
                                        onSubmitted: (String s) {
                                          //TODO: add functionality to the text field,add the text to the list
                                        },
                                        controller: nameColtroler,
                                      ),
                                      const SizedBox(height: 15),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: 50.w, maxHeight: 200),
                                        child: DraggableScrollbar.rrect(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          alwaysVisibleScrollThumb: true,
                                          controller: _scrollControler1,
                                          child: ListView.builder(
                                              controller: _scrollControler1,
                                              itemCount: 10,
                                              itemBuilder: (context, index) {
                                                return Slidable(
                                                  key: UniqueKey(),
                                                  startActionPane: ActionPane(
                                                    // A motion is a widget used to control how the pane animates.
                                                    motion:
                                                        const ScrollMotion(),

                                                    // A pane can dismiss the Slidable.
                                                    dismissible:
                                                        DismissiblePane(
                                                            onDismissed: () {
                                                      //TODO: implement onDismissed logic
                                                      items.removeAt(index);
                                                    }),

                                                    // All actions are defined in the children parameter.
                                                    children: [
                                                      // A SlidableAction can have an icon and/or a label.
                                                    ],
                                                  ),
                                                  child: ListTile(
                                                    title: Text(
                                                      'Item $index',
                                                      style: Theme.of(context)
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.w),
                                  child: const Divider(),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.5.w, vertical: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Add technologies',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      const SizedBox(height: 15),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxHeight: 200, maxWidth: 50.w),
                                        child: DraggableScrollbar.rrect(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          alwaysVisibleScrollThumb: true,
                                          controller: _scrollControler2,
                                          child: ListView.builder(
                                            controller: _scrollControler2,
                                            itemCount: items.length,
                                            itemBuilder: (context, index) {
                                              return ItemWithCheckBox(
                                                text: items[index],
                                                onChanged: (bool? b) {},
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
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                      child: CustomButton(
                        text: 'Done',
                        onPressed: () {
                          //TODO: implement done logic
                        },
                      ),
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
