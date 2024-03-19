class EmployeesRoles {
  final bool admin;
  final bool departmentManager;
  final bool projectManager;

  EmployeesRoles({
    required this.admin,
    required this.departmentManager,
    required this.projectManager,
  });

  factory EmployeesRoles.fromJson(Map<String, dynamic> json) {
    return EmployeesRoles(
      admin: json['admin'],
      departmentManager: json['departmentManager'],
      projectManager: json['projectManager'],
    );
  }

  @override
  String toString() =>
      'EmployeesRoles(admin: $admin, departmentManager: $departmentManager, projectManager: $projectManager)';
}
