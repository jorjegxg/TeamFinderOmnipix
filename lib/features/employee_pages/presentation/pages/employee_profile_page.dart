import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/logo_widget.dart';

class EmployeeProfilePage extends StatelessWidget {
  const EmployeeProfilePage({
    super.key,
    required this.employeeId,
    required this.organizationId,
  });

  final String employeeId;
  final String organizationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.goNamed(AppRouterConst.employeesMainScreen,
              pathParameters: {'organizationId': organizationId}),
        ),
        centerTitle: true,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          const Center(
            child: LogoWidget(
              icon: Icons.person,
            ),
          ),
          const SizedBox(height: 20),
          //TODO: complete with real data
          Text(
            'Employee Name',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Text(
            'Employee email',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Organization admin',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Switch(
                        value: true,
                        onChanged: (newVal) {},
                        activeColor: Theme.of(context).colorScheme.primary),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Department manager',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Switch(
                        value: true,
                        onChanged: (newVal) {},
                        activeColor: Theme.of(context).colorScheme.primary),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Project manager',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Switch(
                        value: true,
                        onChanged: (newVal) {},
                        activeColor: Theme.of(context).colorScheme.primary),
                  ],
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          CustomButton(
            buttonHeight: 40,
            text: 'Save changes',
            onPressed: () {
              //TODO: implement save changes
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
