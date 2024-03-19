class EmployeeModel {
  final String? organizationId;
  final String id;
  final int workingHours;
  final String? departamentId;
  final String email;
  final String name;

  EmployeeModel({
    required this.organizationId,
    required this.id,
    required this.workingHours,
    required this.departamentId,
    required this.email,
    required this.name,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      organizationId: json['organizationId'],
      id: json['id'],
      workingHours: json['workingHours'],
      departamentId: json['departamentId'],
      email: json['email'],
      name: json['name'],
    );
  }
}
