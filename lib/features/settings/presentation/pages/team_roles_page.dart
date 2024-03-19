import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/snack_bar.dart';
import 'package:team_finder_app/features/settings/data/models/role_model.dart';
import 'package:team_finder_app/features/settings/presentation/providers/team_roles_provider.dart';
import 'package:team_finder_app/features/settings/presentation/widgets/field_dialog.dart';
import 'package:team_finder_app/features/settings/presentation/widgets/team_role_card.dart';
import 'package:team_finder_app/injection.dart';

class TeamRolesPage extends HookWidget {
  const TeamRolesPage({
    super.key,
    required this.userId,
  });
  final String userId;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<TeamRolesProvider>()..getTeamRoles(),
      child: Builder(builder: (buildContext) {
        return Consumer(builder: (context, TeamRolesProvider provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Text(provider.error!);
          }
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                provider.getTeamRoles();
              },
              child: Scaffold(
                appBar: AppBar(
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
                            onPress: (String t1, String? t2) {
                              if (t1.isNotEmpty) {
                                provider.addRole(RoleModel(name: t1, id: ''));
                                Navigator.of(context).pop();
                              } else {
                                showSnackBar(
                                    context, 'Role name cannot be empty');
                              }
                            },
                          );
                        },
                      );
                    },
                    child: const Icon(Icons.add, color: Colors.black)),
                body: Sizer(
                  builder: (BuildContext context, Orientation orientation,
                      DeviceType deviceType) {
                    if (provider.teamRoles.isEmpty) {
                      return Center(
                        child: Text(
                          'No Team Roles',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      );
                    }
                    return Center(
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
                                child: ListView.builder(
                                    itemCount: provider.teamRoles.length,
                                    itemBuilder: (context, index) {
                                      return TeamRoleCard(
                                        role: provider.teamRoles[index].name,
                                        onDelete: (BuildContext ctx) {
                                          showDialog(
                                              context: ctx,
                                              builder:
                                                  (BuildContext dialogContext) {
                                                return AlertDialog(
                                                  title: Text(
                                                    "Delete Role",
                                                    style:
                                                        Theme.of(dialogContext)
                                                            .textTheme
                                                            .titleMedium,
                                                  ),
                                                  content: const Text(
                                                      "Are you sure you want to delete this role?Deleting this role will remove it from all users"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        await provider.deleteRole(
                                                            provider.teamRoles[
                                                                index],
                                                            buildContext);
                                                        if (dialogContext
                                                            .mounted) {
                                                          Navigator.of(
                                                                  dialogContext)
                                                              .pop();
                                                        }
                                                      },
                                                      child: const Text('Yes'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(
                                                                dialogContext)
                                                            .pop();
                                                      },
                                                      child: const Text('No'),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
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
            ),
          );
        });
      }),
    );
  }
}
