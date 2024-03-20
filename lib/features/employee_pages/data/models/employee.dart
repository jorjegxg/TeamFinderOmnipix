class Employee {
  final String id;
  final String name;
  final String email;
  final int workingHours;
  bool isCurrentUser;
  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.workingHours,
    this.isCurrentUser = false,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      workingHours: json['workingHours'],
    );
  }

  //tostr
  @override
  String toString() {
    return 'Employee{id: $id, name: $name, email: $email}';
  }
}
