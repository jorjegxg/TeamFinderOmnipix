import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departament_projects_provider.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/filter_projects_dialog.dart';

import 'package:team_finder_app/features/project_pages/presentation/widgets/project_widget.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/search_text_field.dart';
import 'package:team_finder_app/injection.dart';

class DepartamentProjectsPage extends HookWidget {
  const DepartamentProjectsPage({
    super.key,
    required this.userId,
    required this.departamentId,
  });
  final String userId;
  final String departamentId;

  @override
  Widget build(BuildContext context) {
    List<String> items = List.generate(10, (index) => 'Item $index');
    final TextEditingController nameConttroler = TextEditingController();
    return ChangeNotifierProvider(
      create: (context) => getIt<DepartamentProjectsProvider>()
        ..fetchProjectsForDepartament(departamentId),
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
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                      dropdownValue:
                                          AppLists.projectStatusList[0],
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
                          child: Consumer<DepartamentProjectsProvider>(
                            builder: (context, provider, state) => provider
                                    .isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : provider.projects.isEmpty
                                    ? Text(
                                        'No projects found',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      )
                                    : ListView.builder(
                                        itemCount: provider.projects.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: ProjectWidget(
                                              mainTitle:
                                                  provider.projects[index].name,
                                              title1: 'Project Period:',
                                              title2: provider
                                                  .projects[index].period
                                                  .toString(),
                                              content1: 'Project Status:',
                                              content2: provider
                                                  .projects[index].status,
                                              onPressed: () {},
                                            ),
                                          );
                                        },
                                      ),
                          ),
                        ),
                        const SizedBox(height: 60),
                      ],
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
