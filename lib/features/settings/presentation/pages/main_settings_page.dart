import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/departament_info_widget.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/widgets/option_widget.dart';
import 'package:team_finder_app/features/settings/presentation/widgets/field_dialog.dart';

class MainSettingsPage extends StatelessWidget {
  const MainSettingsPage({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              //TODO: Implement Logout
            },
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        ],
        centerTitle: true,
        title: Text(
          'Departaments',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: const Column(
        children: [
          SizedBox(height: 20),
          Center(
              child: InfoWidget(
            text: 'Employee Name',
            text2: 'Employee email',
            icon: Icons.person,
          )),
          SizedBox(height: 20),
          DetailsBodyWidget()
        ],
      ),
    );
  }
}

class DetailsBodyWidget extends StatelessWidget {
  const DetailsBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Theme.of(context).colorScheme.onSurface,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              OptionWidget(
                text: 'Edit Profile',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => FieldDialog(
                      onPress: () {
                        //TODO: add functionality to the edit button
                        Navigator.pop(context);
                      },
                      title: 'Edit Profile',
                      text1: 'Name',
                      text2: 'Email',
                    ),
                  );
                },
              ),
              OptionWidget(
                text: 'Personal Skills',
                onPressed: () {
                  context.goNamed(AppRouterConst.personalSkillsPage,
                      pathParameters: {'userId': 'userId'});
                },
              ),
              OptionWidget(
                text: 'Create Team Roles',
                onPressed: () {
                  context.goNamed(AppRouterConst.teamRolesPage,
                      pathParameters: {'userId': 'userId'});
                },
              ),
              OptionWidget(
                text: 'Change Password',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => FieldDialog(
                      title: 'Change Password',
                      text1: 'New Password',
                      text2: 'Confirm Password',
                      onPress: () {
                        //TODO: add functionality to the edit button
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
