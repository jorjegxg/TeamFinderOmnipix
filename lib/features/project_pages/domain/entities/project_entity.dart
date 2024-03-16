import 'package:team_finder_app/features/project_pages/data/models/technology_stack.dart';

class ProjectEntity {
  final String id;
  final String name;
  final Map<String, int> teamRoles;
  final List<TechnologyStack> technologyStack;
  final String projectManager;

  ProjectEntity({
    required this.id,
    required this.name,
    required this.teamRoles,
    required this.technologyStack,
    required this.projectManager,
  });
}
