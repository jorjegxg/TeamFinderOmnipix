import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_dropdown_button.dart';

class AssignmentProposalScreen extends HookWidget {
  const AssignmentProposalScreen({
    required this.employeeId,
    super.key,
    required this.projectId,
    required this.userId,
  });

  final String employeeId;
  final String projectId;
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
            onPressed: () => context.goNamed(AppRouterConst.addProjectMember,
                pathParameters: {'projectId': projectId, 'userId': userId}),
          ),
          centerTitle: true,
          title: Text(
            'Send Assignment Proposal',
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
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextField(
                                      nameConttroler: nameColtroler,
                                      hintText: 'Work Hours',
                                      width: 90.w,
                                      onSubmitted: (String s) {
                                        //TODO: implement onSubmitted logic
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    Text('Project Roles',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                    CustomDropdownButton(
                                      elements: const ['Software', 'Hardware'],
                                      buttonWidth: 80.w,
                                      onChanged: (String? value) {
                                        //TODO: implement onChanged logic
                                        //add item to items list, and display it as a chip
                                        //and remove it from the elements list, so it can't be added again
                                        //also add a delete button to the chip
                                        //when the delete button is pressed, remove the item from the items list
                                        //and add it back to the elements list
                                      },
                                      dropdownValue: 'Software',
                                    ),
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxHeight: 10.h),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: items.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Chip(
                                              backgroundColor: Theme.of(context)
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
                    const SizedBox(height: 20),
                    CustomButton(
                      text: 'Done',
                      onPressed: () {
                        //TODO: implement done logic
                        context.goNamed(AppRouterConst.addProjectMember,
                            pathParameters: {
                              'projectId': projectId,
                              'userId': userId
                            });
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
