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

/**{
  "name": "Nume test dep",
  "organizationId": "88E6HD3QK9x4QU1CxOuh",
  "id": "f8XEN9GUe6Zlx2orfhiw",
  "departamentManagerId": null
} */
