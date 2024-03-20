import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/suggestion_text_field.dart';
import 'package:team_finder_app/features/settings/presentation/providers/create_skill_provider.dart';
import 'package:team_finder_app/injection.dart';

class CreateSkillPage extends HookWidget {
  const CreateSkillPage({
    super.key,
    required this.userId,
  });

  final String userId;
  @override
  Widget build(BuildContext context) {
    final nameColtroler = useTextEditingController();
    final descriptionColtroler = useTextEditingController();
    final skillCatColtroller = useTextEditingController();

    return ChangeNotifierProvider(
      create: (context) =>
          getIt<CreateSkillProvider>()..fetchCategoriesSugestions(),
      child: Builder(builder: (context) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Create Skill',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: Sizer(
              builder: (BuildContext context, Orientation orientation,
                  DeviceType deviceType) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Consumer<CreateSkillProvider>(
                      builder: (context, provider, child) => Column(
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
                                          CustomTextField(
                                            nameConttroler: nameColtroler,
                                            hintText: 'Skill Name',
                                            width: 90.w,
                                            onSubmitted: (String s) {
                                              provider.setName(s);
                                            },
                                          ),
                                          const SizedBox(height: 20),
                                          Text('Skill Categories',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall),
                                          SuggestionTextField(
                                              options:
                                                  provider.categoriesSugestions,
                                              onSubmitted: (String s) {
                                                provider.setCategory(s);
                                              },
                                              controller: skillCatColtroller),
                                          // ConstrainedBox(
                                          //   constraints:
                                          //       BoxConstraints(maxHeight: 10.h),
                                          //   child:
                                          //  ListView.builder(
                                          //   scrollDirection: Axis.horizontal,
                                          //   itemCount: items.length,
                                          //   itemBuilder: (context, index) {
                                          //     return Padding(
                                          //       padding:
                                          //           const EdgeInsets.all(8.0),
                                          //       child:
                                          //     Chip(
                                          //   backgroundColor: Theme.of(context)
                                          //       .colorScheme
                                          //       .primary,
                                          //   label: Text(provider.category,
                                          //       style: Theme.of(context)
                                          //           .textTheme
                                          //           .titleSmall),
                                          //   onDeleted: () {
                                          //     provider.clearCategory();
                                          //     // items.removeAt(index);
                                          //   },
                                          // ),
                                          // );
                                          // },
                                          // ),
                                          // ),
                                          const SizedBox(height: 40),
                                          CustomTextField(
                                            nameConttroler:
                                                descriptionColtroler,
                                            hintText: "description",
                                            keyboardType:
                                                TextInputType.multiline,
                                            minLines: 10,
                                            width: 90.w,
                                            onSubmitted: (String s) {
                                              provider.setDescription(s);
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
                              provider
                                  .setDescription(descriptionColtroler.text);
                              provider.setCategory(skillCatColtroller.text);
                              provider.setName(nameColtroler.text);
                              await Provider.of<CreateSkillProvider>(context,
                                      listen: false)
                                  .createSkill(context);
                              if (!context.mounted) return;
                              context.goNamed(
                                AppRouterConst.settingsMainScreen,
                                pathParameters: {'userId': userId},
                              );
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
