import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';
import 'package:team_finder_app/features/project_pages/data/models/team_role.dart';

class EmployeeTeamRole extends Employee {
  final List<TeamRole> teamRoles;

  EmployeeTeamRole({
    required super.id,
    required super.name,
    required super.email,
    required super.workingHours,
    required this.teamRoles,
  });

  factory EmployeeTeamRole.fromJson(Map<String, dynamic> json) {
    return EmployeeTeamRole(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      workingHours: json['workingHours'],
      teamRoles: (json['teamRolesId'] as List)
          .map((teamRole) => TeamRole.fromJson(teamRole))
          .toList(),
    );
  }
}
