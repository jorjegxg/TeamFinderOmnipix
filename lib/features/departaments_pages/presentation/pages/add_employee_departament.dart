import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sizer/sizer.dart';

import 'package:team_finder_app/features/project_pages/presentation/widgets/item_with_checkbox.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/search_text_field.dart';

class AddEmployeeToDepartamentPage extends HookWidget {
  const AddEmployeeToDepartamentPage({
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
            'Add Employees',
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
                    SearchTextField(
                      nameConttroler: nameConttroler,
                      onSubmitted: (String s) {},
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: ItemWithCheckBox(
                              enabled: true,
                              value: false,
                              text: 'name',
                              onChanged: (bool? b, int number) {
                                //TODO: implement onChanged
                              },
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
