import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/settings/presentation/widgets/field_dialog.dart';
import 'package:team_finder_app/features/settings/presentation/widgets/team_role_card.dart';

class TeamRolesPage extends HookWidget {
  const TeamRolesPage({
    super.key,
    required this.userId,
  });
  final String userId;
  @override
  Widget build(BuildContext context) {
    List<String> items = List.generate(10, (index) => 'Item $index');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.goNamed(AppRouterConst.projectsMainScreen,
                pathParameters: {'userId': userId}),
          ),
          centerTitle: true,
          title: Text(
            'Team Roles',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return FieldDialog(
                    text1: 'Role',
                    title: 'Add Role',
                    onPress: () {
                      //TODO: Implement Add Role
                    },
                  );
                },
              );
            },
            child: const Icon(Icons.add, color: Colors.black)),
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
                    Expanded(
                      child: Card(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return TeamRoleCard(
                                role: items[index],
                                onDelete: (BuildContext ctx) {},
                                onEdit: (BuildContext ctx) {},
                              );
                            }),
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
