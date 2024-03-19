import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/skill_statistics_provider.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_dropdown_button.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_text_container.dart';
import 'package:team_finder_app/injection.dart';

class SkillStatisticsPage extends HookWidget {
  const SkillStatisticsPage({
    super.key,
    required this.userId,
    required this.departamentId,
    required this.departamentName,
  });
  final String userId;
  final String departamentId;
  final String departamentName;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          getIt<SkillStatisticsProvider>()..getSkills(departamentId),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Skill Statistics',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: Sizer(
            builder: (BuildContext context, Orientation orientation,
                DeviceType deviceType) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Consumer<SkillStatisticsProvider>(
                    builder: (context, provider, child) => provider.isLoading
                        ? const CircularProgressIndicator()
                        : provider.skills.isEmpty
                            ? Text(
                                "No skills found",
                                style: Theme.of(context).textTheme.titleLarge,
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: CustomDropdownButton(
                                      elements: provider.skills
                                          .map((e) => e.name)
                                          .toList(),
                                      onChanged: (String? s) {
                                        provider.updateCurrentlySelected(
                                            provider.skills.firstWhere(
                                                (element) =>
                                                    element.name == s));
                                        provider.fetchStatisticsForDepartament(
                                            departamentId);
                                      },
                                      dropdownValue:
                                          provider.currentlySelected!.name,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Expanded(
                                    child: Card(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            child: CustomTextContainer(
                                              text: provider
                                                  .getTotalCount()
                                                  .toString(),
                                            ),
                                          ),
                                          if (provider.statistics.isNotEmpty)
                                            PieChart(
                                              dataMap: provider.statistics.map(
                                                (key, value) => MapEntry(
                                                  "${SkillLevelX.fromInt(int.parse(key)).toStringValue()}: $value",
                                                  value.toDouble(),
                                                ),
                                              ),
                                              animationDuration: const Duration(
                                                  milliseconds: 800),
                                              chartLegendSpacing: 32,
                                              chartRadius:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3.2,
                                              initialAngleInDegree: 0,
                                              chartType: ChartType.disc,
                                              ringStrokeWidth: 32,
                                              legendOptions:
                                                  const LegendOptions(
                                                legendLabels: {
                                                  "Level 1":
                                                      "Levelasdasssssssssssssss 1",
                                                  "Level 2": "Level 2",
                                                  "Level 3": "Level 3",
                                                  "Level 4": "Level 4",
                                                  "Level 5": "Level 5",
                                                },
                                                showLegendsInRow: false,
                                                legendPosition:
                                                    LegendPosition.bottom,
                                                showLegends: true,
                                                legendShape: BoxShape.circle,
                                                legendTextStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              chartValuesOptions:
                                                  const ChartValuesOptions(
                                                showChartValueBackground: true,
                                                showChartValues: false,
                                                showChartValuesInPercentage:
                                                    false,
                                                showChartValuesOutside: false,
                                                decimalPlaces: 1,
                                              ),
                                              // gradientList: ---To add gradient colors---
                                              // emptyColorGradient: ---Empty Color gradient---
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 60),
                                ],
                              ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
