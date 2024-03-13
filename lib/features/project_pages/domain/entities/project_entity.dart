class ProjectEntity {
  final String id;
  final String name;
  final List<String> roles;
  final List<String> technologies;
  final String projectManager;

  ProjectEntity({
    required this.id,
    required this.name,
    required this.roles,
    required this.technologies,
    required this.projectManager,
  });
}
