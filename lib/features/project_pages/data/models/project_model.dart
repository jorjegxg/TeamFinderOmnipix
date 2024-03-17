// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/features/project_pages/data/models/technology_stack.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';

class ProjectModel extends ProjectEntity {
  final ProjectPeriod period;
  final DateTime startDate;
  final DateTime deadlineDate;
  final String description;
  final String organizationId;
  final String status;

  ProjectModel({
    required this.status,
    required super.id,
    required super.name,
    required this.period,
    required this.startDate,
    required this.deadlineDate,
    required this.description,
    required super.technologyStack,
    required super.teamRoles,
    required this.organizationId,
    required super.projectManager,
  });
// {
//   "technologyStack": [
//     {
//       "organizationId": "Aa7xIWqSHdYrJX1KuqAY",
//       "id": "Y6JbE72erahtkJIWBxXF",
//       "name": "REACT JS"
//     },
//     {
//       "organizationId": "Aa7xIWqSHdYrJX1KuqAY",
//       "id": "BK1JTCslSiZgiIN9jW81",
//       "name": "SPRING"
//     }
//   ],
//   "organizationId": "Aa7xIWqSHdYrJX1KuqAY",
//   "description": "UN PROIECT MISTO",
//   "period": "DETERMINATED",
//   "id": "jxbVChPb4iSCw8Mpk0aD",
//   "deadlineDate": "2024-03-15T19:50:06.746Z",
//   "teamRoles": [
//     {
//       "organizationId": "Aa7xIWqSHdYrJX1KuqAY",
//       "id": "MxcBvusNz97CND7T6yog",
//       "name": "FRONTEND DEV",
//       "value": 3
//     },
//     {
//       "organizationId": "Aa7xIWqSHdYrJX1KuqAY",
//       "id": "fpPN2YjcRt2EH9GwhCgB",
//       "name": "BACKEND DEV",
//       "value": 5
//     }
//   ],-
//   "employeeId": "z7oZcmnDWTuvM7bpBD1d",
//   "startDate": "2024-03-15T19:50:06.746Z",
//   "name": "TEAM FINDER APP"
// }
  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    Map<String, int> teamRoles = {};

    map['teamRoles'].forEach((element) {
      teamRoles.putIfAbsent(element['name'], () => element['value']);
    });
    return ProjectModel(
      id: map['id'],
      name: map['name'],
      period: ProjectPeriodX.fromString(map['period']),
      startDate: DateTime.parse(map['startDate']),
      deadlineDate: DateTime.parse(map['deadlineDate']),
      description: map['description'],
      technologyStack: List<TechnologyStack>.from(
          map['technologyStack'].map((x) => TechnologyStack.fromMap(x))),
      teamRoles: teamRoles,
      organizationId: map['organizationId'],
      projectManager: map['employeeId'],
      status: map['status'],
    );
  }

  factory ProjectModel.fromJson(String source) =>
      ProjectModel.fromMap(json.decode(source));

  Timestamp get startDateTimestamp => Timestamp.fromDate(startDate);
  Timestamp get deadlineDateTimestamp => Timestamp.fromDate(deadlineDate);
}
