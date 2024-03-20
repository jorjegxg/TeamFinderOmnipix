class DepartmentSummary {
  final String id;
  final String? managersName;
  final String departmentName;
  final int numberOfEmployees;
  final String departamentManagerId;
  bool isCurrentUserManager;

  DepartmentSummary({
    required this.id,
    required this.managersName,
    required this.departmentName,
    required this.numberOfEmployees,
    required this.departamentManagerId,
    this.isCurrentUserManager = false,
  });

  factory DepartmentSummary.fromJson(Map<String, dynamic> json) {
    return DepartmentSummary(
      id: json['id'],
      managersName: json['managersName'],
      departmentName: json['name'],
      numberOfEmployees: json['numberOfEmployees'] ?? 0,
      //TODO George Luta : o sa trebuiasca sa schimbi din departamentManagerId in employeeId (vezi cum iti da data)
      departamentManagerId: json['departamentManagerId'],
    );
  }
}
