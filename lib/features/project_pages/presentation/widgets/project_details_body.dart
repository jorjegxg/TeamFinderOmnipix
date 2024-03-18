import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_text_container.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/view_list_dialog.dart';

class MobileProjectDetailsBody extends StatelessWidget {
  const MobileProjectDetailsBody({
    super.key,
    required this.project,
  });
  final ProjectEntity project;
  @override
  Widget build(BuildContext context) {
    return Card(
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
                    const SizedBox(height: 5),
                    Text('Project Name',
                        style: Theme.of(context).textTheme.titleSmall),
                    CustomTextContainer(
                      text: project.name,
                    ),
                    const SizedBox(height: 20),
                    Text('Project period',
                        style: Theme.of(context).textTheme.titleSmall),
                    CustomTextContainer(
                      text: project.period.toStringValue(),
                    ),
                    const SizedBox(height: 20),
                    Text('Project Status',
                        style: Theme.of(context).textTheme.titleSmall),
                    CustomTextContainer(
                      text: project.status,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Start Date:',
                            style: Theme.of(context).textTheme.titleSmall),
                        Text(project.startDateString,
                            style: Theme.of(context).textTheme.titleSmall),
                        SizedBox(width: 10.w),
                        Text('End Date:',
                            style: Theme.of(context).textTheme.titleSmall),
                        Text(project.deadlineDateString,
                            style: Theme.of(context).textTheme.titleSmall),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          text: 'View tehnologies',
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => ViewListDialog(
                                      list: project.technologyStack
                                          .map((e) => e.name)
                                          .toList(),
                                      title: 'View Technologies',
                                    ));
                          },
                          buttonWidth: 20.w,
                          buttonHeight: 5.h,
                        ),
                        CustomButton(
                          text: 'View team roles',
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => ViewListDialog(
                                      list: project.teamRoles.keys.map((e) {
                                        return e.name;
                                      }).toList(),
                                      title: 'View team roles',
                                    ));
                          },
                          buttonWidth: 20.w,
                          buttonHeight: 5.h,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomTextContainer(
                      text: project.description,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DesktopProjectDetailsScreen extends HookWidget {
  const DesktopProjectDetailsScreen({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollControler1 = useScrollController();
    final ScrollController scrollControler2 = useScrollController();

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
    return Card(
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
                              const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomTextContainer(
                                    text: 'Project Name',
                                  ),
                                  CustomTextContainer(
                                    text: 'Project period',
                                  ),
                                  CustomTextContainer(
                                    text: 'Project status',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                          child: SizedBox(
                            width: getValueForScreenType(
                                context: context,
                                mobile: 50.w,
                                // tablet: 35.w,
                                desktop: 40.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Start Date:',
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                                Text('10/02/2022',
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                                SizedBox(width: 5.w),
                                Text('End Date:',
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                                Text('10/02/2024',
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                          child: CustomTextContainer(
                              width: 30.w,
                              height: 200,
                              text:
                                  'descriptiodddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddn'),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.5.w, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'View team roles',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(height: 15),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: 20.w, maxHeight: 200),
                                child: DraggableScrollbar.rrect(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  alwaysVisibleScrollThumb: true,
                                  controller: scrollControler1,
                                  child: ListView.builder(
                                      controller: scrollControler1,
                                      itemCount: 10,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(
                                            'Item ${items[index]}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
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
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: const Divider(),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.5.w, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'View technologies',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(height: 15),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight: 200, maxWidth: 20.w),
                                child: DraggableScrollbar.rrect(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  alwaysVisibleScrollThumb: true,
                                  controller: scrollControler2,
                                  child: ListView.builder(
                                    controller: scrollControler2,
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(
                                          'Item ${items[index]}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
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
        ],
      ),
    );
  }
}

class TabletProjectDetailsScreen extends HookWidget {
  const TabletProjectDetailsScreen({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollControler1 = useScrollController();
    final ScrollController scrollControler2 = useScrollController();

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
    return Card(
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.w, vertical: 10),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Name:',
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                                Text('Project period:',
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                                Text('Project Status:',
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                              ],
                            ),
                            SizedBox(width: 5.w),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomTextContainer(
                                  text: 'Project Name',
                                ),
                                CustomTextContainer(
                                  text: 'Project period',
                                ),
                                CustomTextContainer(
                                  text: 'Project status',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                        child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Start Date:',
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              Text('10/02/2022',
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              SizedBox(width: 5.w),
                              Text('End Date:',
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              Text('10/02/2024',
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                        child: const CustomTextContainer(
                            text:
                                'descriptiodddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddn'),
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
                              color: Theme.of(context).colorScheme.primary,
                              width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'View team roles',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 15),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: 50.w, maxHeight: 200),
                              child: DraggableScrollbar.rrect(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                alwaysVisibleScrollThumb: true,
                                controller: scrollControler1,
                                child: ListView.builder(
                                    controller: scrollControler1,
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(
                                          'Item ${items[index]}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
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
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: const Divider(),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.5.w, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'View technologies',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 15),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: 50.w, maxHeight: 200),
                              child: DraggableScrollbar.rrect(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                alwaysVisibleScrollThumb: true,
                                controller: scrollControler2,
                                child: ListView.builder(
                                  controller: scrollControler2,
                                  itemCount: items.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        'Item ${items[index]}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
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
        ],
      ),
    );
  }
}
