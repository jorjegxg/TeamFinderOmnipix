class Employee {
  final String id;
  final String name;
  final String email;
  bool isCurrentUser;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    this.isCurrentUser = false,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  //tostr
  @override
  String toString() {
    return 'Employee{id: $id, name: $name, email: $email}';
  }
}
