class Department {
  final String id;
  final String? managersName;
  final String departmentName;
  final int numberOfEmployees;

  Department({
    required this.id,
    required this.managersName,
    required this.departmentName,
    required this.numberOfEmployees,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      managersName: json['managersName'],
      departmentName: json['name'],
      numberOfEmployees: json['numberOfEmployees'] ?? 0,
    );
  }
}
