import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/alocation.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/dealocation.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departament_confirmation_provider.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/filter_projects_dialog.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/requests_card.dart';

import 'package:team_finder_app/features/project_pages/presentation/widgets/search_text_field.dart';
import 'package:team_finder_app/injection.dart';

class ConfirmationPage extends HookWidget {
  const ConfirmationPage({
    super.key,
    required this.userId,
    required this.departamentId,
  });
  final String userId;
  final String departamentId;

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameConttroler = TextEditingController();
    return ChangeNotifierProvider(
      create: (context) => getIt<DepartamentConfirmationProvider>()
        ..fetchAlocations(departamentId)
        ..fetchDealocations(departamentId),
      child: Builder(builder: (context) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Projects',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: Sizer(
              builder: (BuildContext context, Orientation orientation,
                  DeviceType deviceType) {
                return Consumer<DepartamentConfirmationProvider>(
                  builder: (context, provider, child) => provider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : provider.error != null
                          ? Center(
                              child: Text(provider.error!),
                            )
                          : Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SearchTextField(
                                          nameConttroler: nameConttroler,
                                          onSubmitted: (String s) {},
                                        ),
                                        const SizedBox(width: 10),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return FilterProjectsDialog(
                                                  dropdownValue: AppLists
                                                      .projectStatusList[0],
                                                  onPressed: (String? s) {},
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(Icons.filter_alt),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: provider.allItems.isEmpty
                                          ? Center(
                                              child: Text(
                                                'No items',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                            )
                                          : ListView.builder(
                                              itemCount:
                                                  provider.allItems.length,
                                              itemBuilder: (context, index) {
                                                //if este pentru a diferentia dintre cereri de alocare/dealocare din project
                                                if (provider.allItems[index]
                                                    is Dealocation) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: RequestsCard(
                                                      mainTitle: provider
                                                          .allItems[index]
                                                          .employeeName,
                                                      text1: 'Reason:',
                                                      text2: provider
                                                          .allItems[index]
                                                          .dealocationReason,
                                                      onRefuse: () {},
                                                      onAccept: () {},
                                                    ),
                                                  );
                                                } else if (provider
                                                        .allItems[index]
                                                    is Alocation) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: RequestsCard(
                                                      mainTitle: provider
                                                          .allItems[index]
                                                          .employeeName,
                                                      text1: provider
                                                          .allItems[index]
                                                          .workHours
                                                          .toString(),
                                                      text2: provider
                                                          .allItems[index]
                                                          .getTeamRolesString(),
                                                      text3: provider
                                                          .allItems[index]
                                                          .comments,
                                                      onRefuse: () {
                                                        //TODO: Add logic for ACCEPT/REJECT
                                                      },
                                                      onAccept: () {},
                                                    ),
                                                  );
                                                }
                                                return null;
                                              },
                                            ),
                                    ),
                                    const SizedBox(height: 60),
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
