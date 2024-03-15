import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/filter_projects_dialog.dart';

import 'package:team_finder_app/features/project_pages/presentation/widgets/project_widget.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/search_text_field.dart';

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
                                  dropdownValue: AppLists.projectStatusList[0],
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
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: ProjectWidget(
                              mainTitle: 'mainTitle',
                              title1: 'title1',
                              title2: 'title2',
                              content1: 'content1',
                              content2: 'content2',
                              onPressed: () {},
                            ),
                          );
                        },
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
  }
}
