import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:team_finder_app/features/project_pages/data/repositories/project_repo_impl.dart';
import 'package:team_finder_app/features/project_pages/domain/repositories/project_repo.dart';
import 'package:team_finder_app/features/project_pages/domain/usecases/projects_usecase.dart';

class DealocationDialog extends HookWidget {
  const DealocationDialog({required this.projectId, super.key});
  final String projectId;
  @override
  Widget build(BuildContext context) {
    final TextEditingController dealocationController =
        useTextEditingController();

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Dealocation',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 15),
            Text(
              'Please enter a reason for dealocation',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              nameConttroler: dealocationController,
              hintText: 'Enter Dealocation Reason',
              onSubmitted: (String message) {
                //TODO: add functionality to the text field
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
                TextButton(
                  onPressed: () {
                    ProjectsUsecase projectUsecase =
                        ProjectsUsecase(ProjectRepoImpl());
                    projectUsecase.sendDealocationProposal(
                        projectId: projectId,
                        proposal: dealocationController.text);
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
