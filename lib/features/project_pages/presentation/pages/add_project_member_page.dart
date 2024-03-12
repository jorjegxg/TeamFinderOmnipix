import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/filter_dialog.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/new_members_card.dart';

import 'package:team_finder_app/features/project_pages/presentation/widgets/search_text_field.dart';

class AddProjectMembersPage extends HookWidget {
  const AddProjectMembersPage({
    super.key,
    required this.projectId,
    required this.userId,
  });
  final String projectId;
  final String userId;

  @override
  Widget build(BuildContext context) {
    List<String> items = List.generate(10, (index) => 'Item $index');
    TextEditingController nameConttroler = useTextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.goNamed(
                AppRouterConst.projectMembersScreen,
                pathParameters: {'projectId': projectId, 'userId': userId}),
          ),
          centerTitle: true,
          title: Text(
            'Add Members',
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
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SearchTextField(
                          nameConttroler: nameConttroler,
                          onSubmitted: (String message) {},
                        ),
                        IconButton(
                            icon: const Icon(Icons.filter_list,
                                color: Colors.black),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return FilterDialog();
                                  });
                              //TODO: add functionality to the icon button filter
                            }),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Card(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: NewMembersCard(
                                name: 'name',
                                email: 'email',
                                onDoubleTap: () {
                                  //TODO: add functionality to the card
                                  context.goNamed(
                                      AppRouterConst.sendAssignmentProposal,
                                      pathParameters: {
                                        'projectId': projectId,
                                        'employeeId': 'employeeId',
                                        'userId': userId
                                      });
                                },
                              ),
                            );
                          },
                        ),
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
