class Endorsement {
  final String title;
  final String description;
  final String assignedSkillId;
  final String? projectId;

  Endorsement({
    required this.title,
    required this.description,
    required this.assignedSkillId,
    this.projectId,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "assignedSkillId": assignedSkillId,
      "projectId": projectId,
    };
  }
}
