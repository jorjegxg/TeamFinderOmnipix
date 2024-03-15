import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/core/util/snack_bar.dart';
import 'package:team_finder_app/features/employee_pages/domain/employee_usecase.dart';
import 'package:team_finder_app/injection.dart';

class CopyLinkDialog extends HookWidget {
  const CopyLinkDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Add employees link',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 15),
            Text(
              'This link shall be used to add new employees to the app : ',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 15),
            FutureBuilder<String>(
                future: getIt<EmployeeUsecase>().getOrganizationId(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          DynamicLinkConstants.getAddEmployeeToOrganizationLink(
                            organizationId: snapshot.data!,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () {
                          getIt<EmployeeUsecase>().copyLink(
                            DynamicLinkConstants
                                .getAddEmployeeToOrganizationLink(
                                    organizationId: snapshot.data!),
                          );
                          //pop
                          Navigator.pop(context);

                          showSnackBar(context, 'Link copied');
                        },
                      ),
                    ],
                  );
                }),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
