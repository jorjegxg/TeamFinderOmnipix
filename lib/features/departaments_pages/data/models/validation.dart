import 'dart:convert';

import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Validation {
  String employeeName;
  Skill skill;
  int level;
  int experience;
  String id;

  Validation({
    required this.employeeName,
    required this.skill,
    required this.level,
    required this.experience,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'employeeName': employeeName,
      'skill': skill.toJson(),
      'level': level,
      'experience': experience,
      'id': id,
    };
  }

  factory Validation.fromMap(Map<String, dynamic> map) {
    return Validation(
      employeeName: map['employeeName'] as String,
      skill: Skill.fromJson(map['skillId'] as Map<String, dynamic>),
      level: map['level'] as int,
      experience: map['experience'] as int,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Validation.fromJson(String source) =>
      Validation.fromMap(json.decode(source) as Map<String, dynamic>);
}
// "id": "0HxxC7amFaLMsdC2gjZX",
//     "skillId": {
//       "organizationId": "GIVkcCCrciR59rYzG2jx",
//       "description": "dasasdsddas",
//       "id": "RG4u4Wx442mm1FEGSZsE",
//       "authorId": "LZmiWjOR2CbYb44aU1OM",
//       "currentManager": "LZmiWjOR2CbYb44aU1OM",
//       "category": "Software",
//       "name": "SPRI"
//     },
//     "level": 0,
//     "employeeId": "HNeBr7LmxrHzY58WqC8Z",
//     "experience": 0,
//     "employeeName": "siu"