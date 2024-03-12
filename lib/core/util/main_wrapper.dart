import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key, required this.child});
  final Widget child;
  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenTypeLayout.builder(
        mobile: (BuildContext context) => Scaffold(
          body: widget.child,
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.group_work,
                  ),
                  label: 'Projects',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: 'Employees',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.business,
                  ),
                  label: 'Departaments',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'Settings',
                ),
              ],
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Colors.black,
              onTap: (int index) {
                //TODO: imlement navigation  with bloc
                setState(() {
                  _selectedIndex = index;
                  switch (index) {
                    case 0:
                      context.goNamed(AppRouterConst.projectsMainScreen,
                          pathParameters: {'userId': '1'});
                      break;
                    case 1:
                      context.goNamed(
                        AppRouterConst.employeesMainScreen,
                        pathParameters: {'userId': '1'},
                      );
                      break;
                    case 2:
                      context.goNamed(
                        AppRouterConst.departamentsMainScreen,
                        pathParameters: {'userId': '1'},
                      );
                      break;
                    case 3:
                      context.goNamed(AppRouterConst.settingsMainScreen,
                          pathParameters: {'userId': '1'});
                      break;
                  }
                  //TODO: imlement navigation  with bloc
                });
              }),
        ),
        desktop: (BuildContext context) => Scaffold(
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                    switch (index) {
                      case 0:
                        context.goNamed(AppRouterConst.projectsMainScreen,
                            pathParameters: {'userId': '1'});
                        break;
                      case 1:
                        context.goNamed(
                          AppRouterConst.employeesMainScreen,
                          pathParameters: {'userId': '1'},
                        );
                        break;
                      case 2:
                        context.goNamed(
                          AppRouterConst.departamentsMainScreen,
                          pathParameters: {'userId': '1'},
                        );
                        break;
                      case 3:
                        context.goNamed(AppRouterConst.settingsMainScreen,
                            pathParameters: {'userId': '1'});
                        break;
                    }

                    //TODO: imlement navigation  with bloc
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
    );
  }
}
