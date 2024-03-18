class Skill {
  String name;
  String category;
  String description;
  String currentManager;
  String id;

  Skill(
      {required this.name,
      required this.category,
      required this.description,
      required this.currentManager,
      required this.id});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'description': description,
      'currentManager': currentManager,
      'id': id,
    };
  }

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'],
      category: json['category'],
      description: json['description'],
      currentManager: json['currentManager'],
      id: json['id'],
    );
  }
}
