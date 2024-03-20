import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';
import 'package:team_finder_app/features/project_pages/presentation/providers/send_proposal_provider.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_dropdown_button.dart';
import 'package:team_finder_app/injection.dart';

class AssignmentProposalScreen extends HookWidget {
  const AssignmentProposalScreen({
    required this.employeeId,
    super.key,
    required this.projectId,
    required this.userId,
    required this.project,
    required this.workingHours,
  });

  final String employeeId;
  final String projectId;
  final String userId;
  final ProjectEntity project;
  final String workingHours;
  @override
  Widget build(BuildContext context) {
    final descriptionColtroler = useTextEditingController();

    return ChangeNotifierProvider(
      create: (context) => getIt<SendProposalProvider>()..project = project,
      child: Builder(builder: (context) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Send Assignment Proposal',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: Sizer(
              builder: (BuildContext context, Orientation orientation,
                  DeviceType deviceType) {
                return Consumer<SendProposalProvider>(
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
                                const SizedBox(height: 20),
                                Expanded(
                                  child: Card(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceContainer,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 20),
                                                Text('Work Hours',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall),
                                                NumberPicker(
                                                  axis: Axis.horizontal,
                                                  minValue: 1,
                                                  maxValue: 8 -
                                                      int.parse(workingHours),
                                                  value: provider.getWorkHours,
                                                  onChanged: (int nr) {
                                                    provider.workHours = nr;
                                                  },
                                                ),
                                                const SizedBox(height: 20),
                                                Text('Project Roles',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall),
                                                CustomDropdownButton(
                                                  elements: provider.getProject!
                                                      .teamRoles.keys
                                                      .map((e) => e.name)
                                                      .toList(),
                                                  buttonWidth: 80.w,
                                                  onChanged: (String? value) {
                                                    provider
                                                        .addTeamRole(value!);
                                                  },
                                                  dropdownValue: provider
                                                      .getSelectedDropValue!
                                                      .name,
                                                ),
                                                ConstrainedBox(
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxHeight: 100),
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: provider
                                                        .getTeamRoles.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Chip(
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          label: Text(
                                                              provider
                                                                  .getTeamRoles[
                                                                      index]
                                                                  .name,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleSmall),
                                                          onDeleted: () {
                                                            provider.removeTeamRole(
                                                                provider
                                                                    .getTeamRoles[
                                                                        index]
                                                                    .name);
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                CustomTextField(
                                                  nameConttroler:
                                                      descriptionColtroler,
                                                  hintText: "description",
                                                  keyboardType:
                                                      TextInputType.multiline,
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
                                  onPressed: () async {
                                    provider.proposal =
                                        descriptionColtroler.text;
                                    await provider.sendProposal(
                                        context, employeeId);
                                    if (context.mounted) {
                                      context.goNamed(
                                        AppRouterConst.addProjectMember,
                                        pathParameters: {
                                          'projectId': projectId,
                                          'userId': userId
                                        },
                                        extra: project,
                                      );
                                    }
                                  },
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
      }),
    );
  }
}
