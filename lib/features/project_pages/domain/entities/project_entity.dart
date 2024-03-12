class ProjectEntity {
  final String id;
  final String name;
  final List<String> roles;
  final List<String> technologies;

  ProjectEntity({
    required this.id,
    required this.name,
    required this.roles,
    required this.technologies,
  });
}
