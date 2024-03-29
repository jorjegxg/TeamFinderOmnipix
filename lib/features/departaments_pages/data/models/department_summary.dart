class DepartmentSummary {
  final String id;
  final String? managersName;
  final String departmentName;
  final int numberOfEmployees;
  final String? departamentManagerId;
  final String? employeeId;
  bool isCurrentUserManager;

  DepartmentSummary({
    required this.id,
    required this.managersName,
    required this.departmentName,
    required this.numberOfEmployees,
    this.departamentManagerId,
    this.employeeId,
    this.isCurrentUserManager = false,
  });

  factory DepartmentSummary.fromJson(Map<String, dynamic> json) {
    return DepartmentSummary(
      id: json['id'],
      managersName: json['managersName'],
      departmentName: json['name'],
      numberOfEmployees: json['numberOfEmployees'] ?? 0,
      departamentManagerId: json['departamentManagerId'],
      employeeId: json['employeeId'],
    );
  }
}
