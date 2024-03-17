class Skill {
  String name;
  String category;
  String description;
  String currentManager;

  Skill(
      {required this.name,
      required this.category,
      required this.description,
      required this.currentManager});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'description': description,
      'currentManager': currentManager,
    };
  }

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'],
      category: json['category'],
      description: json['description'],
      currentManager: json['currentManager'],
    );
  }
}
