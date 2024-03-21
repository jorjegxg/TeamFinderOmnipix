import 'package:hive/hive.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/features/project_pages/data/models/team_role.dart';
import 'package:team_finder_app/features/project_pages/data/models/technology_stack.dart';

part 'project_entity.g.dart';

@HiveType(typeId: 0)
class ProjectEntity extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final Map<TeamRole, int> teamRoles;
  @HiveField(3)
  final List<TechnologyStack> technologyStack;
  @HiveField(4)
  final String projectManager;
  @HiveField(5)
  final ProjectPeriod period;
  @HiveField(6)
  final DateTime startDate;
  @HiveField(7)
  final DateTime deadlineDate;
  @HiveField(8)
  final String description;
  @HiveField(9)
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
