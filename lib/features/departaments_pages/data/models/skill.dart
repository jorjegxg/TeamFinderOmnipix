class Skill {
  String name;
  String category;
  String description;

  Skill(
      {required this.name, required this.category, required this.description});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'description': description,
    };
  }

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'],
      category: json['category'],
      description: json['description'],
    );
  }
}
