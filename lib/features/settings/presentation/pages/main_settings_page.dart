import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/snack_bar.dart';
import 'package:team_finder_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/departament_info_widget.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/option_widget.dart';
import 'package:team_finder_app/features/settings/presentation/providers/profile_provider.dart';
import 'package:team_finder_app/features/settings/presentation/widgets/field_dialog.dart';

class MainSettingsPage extends StatelessWidget {
  const MainSettingsPage({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, provider, child) {
      if (provider.isLoading) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutRequested(
                      context: context,
                    ));
              },
              icon: const Icon(Icons.logout),
            ),
          ],
          centerTitle: true,
          title: Text(
            'Settings',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Center(
                child: InfoWidget(
              text: provider.name,
              text2: provider.email,
              icon: Icons.person,
            )),
            const SizedBox(height: 20),
            DetailsBodyWidget(
              userId: userId,
            )
          ],
        ),
      );
    });
  }
}

class DetailsBodyWidget extends StatelessWidget {
  const DetailsBodyWidget({
    required this.userId,
    super.key,
  });
  final String userId;
  @override
  Widget build(BuildContext buildContext) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.all(10),
        // color: Theme.of(buildContext).colorScheme.primaryContainer,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              OptionWidget(
                text: 'Edit Profile',
                onPressed: () {
                  showDialog(
                    context: buildContext,
                    builder: (ctx) => Consumer<ProfileProvider>(
                      builder: (context, provider, _) => FieldDialog(
                        onPress: (String t1, String? t2) async {
                          if (t1.isEmpty || t2!.isEmpty) {
                            showSnackBar(ctx, "Name and email cannot be empty");
                          } else {
                            provider.setNewName(t1);
                            provider.setNewEmail(t2);
                            Navigator.pop(context);
                            await provider.updateNameAndEmail();
                          }
                        },
                        title: 'Edit Profile',
                        text1: 'Name',
                        text2: 'Email',
                      ),
                    ),
                  );
                },
              ),
              OptionWidget(
                text: 'Personal Skills',
                onPressed: () {
                  buildContext.goNamed(AppRouterConst.personalSkillsPage,
                      pathParameters: {'userId': userId});
                },
              ),
              OptionWidget(
                text: 'Create Team Roles',
                onPressed: () {
                  buildContext.goNamed(AppRouterConst.teamRolesPage,
                      pathParameters: {'userId': userId});
                },
              ),
              OptionWidget(
                text: 'Change Password',
                onPressed: () {
                  showDialog(
                    context: buildContext,
                    builder: (ctx) => Consumer<ProfileProvider>(
                      builder: (context, provider, _) => FieldDialog(
                        title: 'Change Password',
                        text1: 'New Password',
                        text2: 'Confirm Password',
                        onPress: (String t1, String? t2) async {
                          await provider.changePassword(t1, t2!);
                          if (provider.error != null) {
                            if (!context.mounted) return;
                            showSnackBar(ctx, provider.error!);
                          } else {
                            if (!context.mounted) return;
                            showSnackBar(ctx, "Password changed successfully");
                            Navigator.pop(ctx);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
              OptionWidget(
                text: 'Create Skill',
                onPressed: () {
                  buildContext.goNamed(AppRouterConst.ownedSkillPage,
                      pathParameters: {'userId': userId});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
