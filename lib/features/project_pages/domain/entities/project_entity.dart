import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/features/project_pages/data/models/team_role.dart';
import 'package:team_finder_app/features/project_pages/data/models/technology_stack.dart';

class ProjectEntity {
  final String id;
  final String name;
  final Map<TeamRole, int> teamRoles;
  final List<TechnologyStack> technologyStack;
  final String projectManager;
  final ProjectPeriod period;
  final DateTime startDate;
  final DateTime deadlineDate;
  final String description;
  final String status;

  ProjectEntity({
    required this.id,
    required this.name,
    required this.teamRoles,
    required this.technologyStack,
    required this.projectManager,
    required this.period,
    required this.startDate,
    required this.deadlineDate,
    required this.description,
    required this.status,
  });

  //getters for date format string only day-month-year
  String get startDateString => startDate.toIso8601String().split('T')[0];
  String get deadlineDateString => deadlineDate.toIso8601String().split('T')[0];
}
