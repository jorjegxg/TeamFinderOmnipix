class RoleModel {
  final String name;
  final String id;

  RoleModel({required this.name, required this.id});

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }
}
