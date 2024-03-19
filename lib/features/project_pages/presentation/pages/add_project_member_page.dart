import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';
import 'package:team_finder_app/features/project_pages/presentation/providers/add_member_provider.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/filter_dialog.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/new_members_card.dart';

import 'package:team_finder_app/features/project_pages/presentation/widgets/search_text_field.dart';

class AddProjectMembersPage extends StatefulWidget {
  const AddProjectMembersPage({
    super.key,
    required this.projectId,
    required this.userId,
    required this.project,
  });
  final String projectId;
  final String userId;
  final ProjectEntity project;

  @override
  State<AddProjectMembersPage> createState() => _AddProjectMembersPageState();
}

class _AddProjectMembersPageState extends State<AddProjectMembersPage> {
  TextEditingController nameConttroler = TextEditingController();
  TextEditingController aditionalConttroler = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<AddMembersProvider>(context, listen: false)
          .fetchMembers(widget.projectId);
    });
    super.initState();
  }

  @override
  void dispose() {
    nameConttroler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Add Members',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Sizer(
          builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) {
            return Consumer<AddMembersProvider>(
              builder: (context, provider, child) => provider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
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
                                            return Consumer<AddMembersProvider>(
                                              builder: (context, value,
                                                      child) =>
                                                  FilterDialog(
                                                      onChanged: (double d) {
                                                        value.setNoOfWeeks =
                                                            d.toInt();
                                                      },
                                                      value: value.noOfWeeks
                                                          .toDouble(),
                                                      partiallyAvailable:
                                                          value.partialyAvabile,
                                                      isUnavailable:
                                                          value.unAvabile,
                                                      closeToFinish:
                                                          value.closeToFinish,
                                                      onPartiallyAvailable:
                                                          (bool? b) {
                                                        value.setPartialyAvabile =
                                                            b!;
                                                      },
                                                      onIsUnavailable:
                                                          (bool? b) {
                                                        value.setUnAvabile = b!;
                                                      },
                                                      onCloseToFinish:
                                                          (bool? b) {
                                                        value.setCloseToFinish =
                                                            b!;
                                                      },
                                                      onAdd: () {
                                                        value.fetchMembers(
                                                            widget.projectId);
                                                        Navigator.pop(context);
                                                      }),
                                            );
                                          });
                                      //TODO: add functionality to the icon button filter
                                    }),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomTextField(
                                  nameConttroler: aditionalConttroler,
                                  hintText: 'Aditional Search',
                                ),
                                IconButton(
                                  icon: const Icon(Icons.search,
                                      color: Colors.black),
                                  onPressed: () {
                                    provider.fetchMembersWithChatGPT(
                                      aditionalConttroler.text,
                                    );
                                  },
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: Card(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainer,
                                child: ListView.builder(
                                  itemCount: provider.getMembers.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: NewMembersCard(
                                        name: provider.getMembers[index].name,
                                        email: provider.getMembers[index].email,
                                        onDoubleTap: () {
                                          //TODO: add functionality to the card
                                          context.goNamed(
                                            AppRouterConst
                                                .sendAssignmentProposal,
                                            pathParameters: {
                                              'projectId': widget.projectId,
                                              'employeeId':
                                                  provider.getMembers[index].id,
                                              'userId': widget.userId
                                            },
                                            extra: widget.project,
                                          );
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
                    ),
            );
          },
        ),
      ),
    );
  }
}
