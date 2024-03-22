import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/features/employee_pages/presentation/provider/employee_roles_provider.dart';
import 'package:team_finder_app/features/employee_pages/presentation/provider/employees_provider.dart';
import 'package:team_finder_app/features/settings/presentation/providers/profile_provider.dart';
import 'package:team_finder_app/injection.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key, required this.child});
  final Widget child;
  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

int _selectedIndex = 0;

class _MainWrapperState extends State<MainWrapper> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => getIt<EmployeeRolesProvider>().getCurrentEmployeeRoles());
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => getIt<ProfileProvider>().fetchNameAndEmail());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = Hive.box<int>(HiveConstants.currentIndexBox);
      _selectedIndex = box.get(HiveConstants.currentIndexBox, defaultValue: 0)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<EmployeesProvider>(
            create: (context) => getIt<EmployeesProvider>()..fetchEmployees(),
          ),
        ],
        child: Consumer<EmployeeRolesProvider>(builder: (context, prov, child) {
          return SafeArea(
            child: ValueListenableBuilder(
              valueListenable:
                  Hive.box<int>(HiveConstants.currentIndexBox).listenable(),
              builder: (context, indexBox, child) => ValueListenableBuilder(
                valueListenable:
                    Hive.box<String>(HiveConstants.authBox).listenable(),
                builder: (context, box, child) => ScreenTypeLayout.builder(
                  mobile: (BuildContext context) {
                    const projectsNavigationBarItem = BottomNavigationBarItem(
                      icon: Icon(
                        Icons.group_work,
                      ),
                      label: 'Projects',
                    );
                    const employeesNavigationBarItem = BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                      ),
                      label: 'Employees',
                    );
                    const departmentsNavigationBarItem =
                        BottomNavigationBarItem(
                      icon: Icon(
                        Icons.business,
                      ),
                      label: 'Departaments',
                    );
                    const settingsNavigationBarItem = BottomNavigationBarItem(
                      icon: Icon(
                        Icons.settings,
                      ),
                      label: 'Settings',
                    );
                    return Scaffold(
                        resizeToAvoidBottomInset: false,
                        body: widget.child,
                        bottomNavigationBar: BottomNavigationBar(
                          currentIndex: _selectedIndex,
                          showSelectedLabels: false,
                          showUnselectedLabels: false,
                          items:
                              //TODO George Luta : de ce nu merge ??
                              prov.isOrganizationAdmin
                                  ? const <BottomNavigationBarItem>[
                                      projectsNavigationBarItem,
                                      employeesNavigationBarItem,
                                      departmentsNavigationBarItem,
                                      settingsNavigationBarItem,
                                    ]
                                  : prov.isDepartmentManager
                                      ? [
                                          projectsNavigationBarItem,
                                          departmentsNavigationBarItem,
                                          settingsNavigationBarItem,
                                        ]
                                      : [
                                          departmentsNavigationBarItem,
                                          settingsNavigationBarItem,
                                        ],
                          //TODO George Luta : daca e department manager sa mai adaugi o optiune de a vedea angajatii din departamentul lui (item no 3)
                          selectedItemColor:
                              Theme.of(context).colorScheme.primary,
                          unselectedItemColor: Colors.black,
                          onTap: (int index) {
                            setState(() {
                              indexBox.put(
                                  HiveConstants.currentIndexBox, index);
                              _selectedIndex = index;
                              if (prov.isOrganizationAdmin) {
                                switch (index) {
                                  case 0:
                                    goToProjectsPage(context, box);
                                    break;
                                  case 1:
                                    goToEmployeesPage(context, box);
                                    break;
                                  case 2:
                                    goToDepartmentsPage(context, box);
                                    break;
                                  case 3:
                                    goToSettingsPage(context, box);
                                    break;
                                }
                              } else if (prov.isDepartmentManager) {
                                switch (index) {
                                  case 0:
                                    goToProjectsPage(context, box);
                                    break;
                                  case 1:
                                    goToDepartmentsPage(context, box);
                                    break;
                                  case 2:
                                    goToSettingsPage(context, box);
                                    break;
                                }
                              } else {
                                switch (index) {
                                  case 0:
                                    goToProjectsPage(context, box);
                                    break;

                                  case 1:
                                    goToSettingsPage(context, box);
                                    break;
                                }
                              }
                            });
                          },
                        ));
                  },
                  desktop: (BuildContext context) => Scaffold(
                    body: Row(
                      children: [
                        NavigationRail(
                          selectedIndex: _selectedIndex,
                          onDestinationSelected: (int index) {
                            indexBox.put(HiveConstants.currentIndexBox, index);
                            setState(() {
                              _selectedIndex = index;
                              switch (index) {
                                case 0:
                                  context.goNamed(
                                      AppRouterConst.projectsMainScreen,
                                      pathParameters: {
                                        'userId': box
                                            .get(HiveConstants.organizationId)!
                                      });
                                  break;
                                case 1:
                                  context.goNamed(
                                    AppRouterConst.employeesMainScreen,
                                    pathParameters: {
                                      'userId':
                                          box.get(HiveConstants.organizationId)!
                                    },
                                  );
                                  break;
                                case 2:
                                  context.goNamed(
                                    AppRouterConst.departamentsMainScreen,
                                    pathParameters: {
                                      'userId':
                                          box.get(HiveConstants.organizationId)!
                                    },
                                  );
                                  break;
                                case 3:
                                  context.goNamed(
                                      AppRouterConst.settingsMainScreen,
                                      pathParameters: {
                                        'userId': box
                                            .get(HiveConstants.organizationId)!
                                      });
                                  break;
                              }
                            });
                          },
                          labelType: NavigationRailLabelType.none,
                          destinations: const <NavigationRailDestination>[
                            NavigationRailDestination(
                              icon: Icon(Icons.group_work),
                              selectedIcon: Icon(Icons.group_work),
                              label: Text('Projects'),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.person),
                              selectedIcon: Icon(Icons.person),
                              label: Text('Employees'),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.business),
                              selectedIcon: Icon(Icons.business),
                              label: Text('Departaments'),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.settings),
                              selectedIcon: Icon(Icons.settings),
                              label: Text('Settings'),
                            ),
                          ],
                        ),
                        const VerticalDivider(thickness: 1, width: 1),
                        Expanded(
                          child: widget.child,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }

  void goToSettingsPage(BuildContext context, Box<String> box) {
    context.goNamed(AppRouterConst.settingsMainScreen,
        pathParameters: {'userId': box.get(HiveConstants.organizationId)!});
  }

  void goToDepartmentsPage(BuildContext context, Box<String> box) {
    context.goNamed(
      AppRouterConst.departamentsMainScreen,
      pathParameters: {'userId': box.get(HiveConstants.organizationId)!},
    );
  }

  void goToEmployeesPage(BuildContext context, Box<String> box) {
    context.goNamed(
      AppRouterConst.employeesMainScreen,
      pathParameters: {'userId': box.get(HiveConstants.organizationId)!},
    );
  }

  void goToProjectsPage(BuildContext context, Box<String> box) {
    context.goNamed(AppRouterConst.projectsMainScreen,
        pathParameters: {'userId': box.get(HiveConstants.organizationId)!});
  }
}
