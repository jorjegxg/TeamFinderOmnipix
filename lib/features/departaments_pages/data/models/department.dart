class DepartmentSummary {
  final String id;
  final String? managersName;
  final String departmentName;
  final int numberOfEmployees;

  DepartmentSummary({
    required this.id,
    required this.managersName,
    required this.departmentName,
    required this.numberOfEmployees,
  });

  factory DepartmentSummary.fromJson(Map<String, dynamic> json) {
    return DepartmentSummary(
      id: json['id'],
      managersName: json['managersName'],
      departmentName: json['name'],
      numberOfEmployees: json['numberOfEmployees'] ?? 0,
    );
  }
}
