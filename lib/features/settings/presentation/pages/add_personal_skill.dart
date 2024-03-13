import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_dropdown_button.dart';

class AddPersonalSkillPage extends HookWidget {
  const AddPersonalSkillPage({super.key, required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context) {
    final nameColtroler = useTextEditingController();
    final descriptionColtroler = useTextEditingController();
    List<String> items = List.generate(10, (index) => 'Item $index');
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
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomDropdownButton(
                                        elements: const ['Fixed', 'Ongoing'],
                                        buttonWidth: 80.w,
                                        onChanged: (String? value) {
                                          //TODO: implement onChanged logic
                                        },
                                        dropdownValue: 'Fixed',
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomDropdownButton(
                                        elements: const ['Fixed', 'Ongoing'],
                                        buttonWidth: 80.w,
                                        onChanged: (String? value) {
                                          //TODO: implement onChanged logic
                                        },
                                        dropdownValue: 'Fixed',
                                      ),
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
                                      Divider(),
                                      const SizedBox(height: 20),
                                      Center(
                                        child: Column(
                                          children: [
                                            CustomTextField(
                                              nameConttroler: nameColtroler,
                                              hintText: 'Title',
                                              onSubmitted: (String s) {},
                                            ),
                                            const SizedBox(height: 20),
                                            CustomTextField(
                                              nameConttroler:
                                                  descriptionColtroler,
                                              hintText: 'Description',
                                              onSubmitted: (String s) {},
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomButton(
                                            text: 'Add Endorsements',
                                            onPressed: () {
                                              //TODO: implement onPressed logic
                                            },
                                            buttonWidth: 20.w,
                                            buttonHeight: 5.h,
                                          ),
                                          CustomButton(
                                            text: 'Add project',
                                            onPressed: () {},
                                            buttonWidth: 20.w,
                                            buttonHeight: 5.h,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      ConstrainedBox(
                                        constraints:
                                            BoxConstraints(maxHeight: 10.h),
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: items.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Chip(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                label: Text('Software',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall),
                                                onDeleted: () {
                                                  items.removeAt(index);
                                                },
                                              ),
                                            );
                                          },
                                        ),
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
                      text: 'Add',
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
