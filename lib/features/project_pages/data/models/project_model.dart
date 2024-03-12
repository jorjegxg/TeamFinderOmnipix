// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_finder_app/features/project_pages/data/models/technology_stack.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';

enum ProjectPeriod { fixed, ongoing }

extension ProjectPeriodX on ProjectPeriod {
  static ProjectPeriod fromString(String period) {
    if (period == 'fixed') {
      return ProjectPeriod.fixed;
    } else {
      return ProjectPeriod.ongoing;
    }
  }

  toStringValue() {
    if (this == ProjectPeriod.fixed) {
      return 'fixed';
    } else {
      return 'ongoing';
    }
  }
}

class ProjectModel extends ProjectEntity {
  final ProjectPeriod period;
  final DateTime startDate;
  final DateTime deadlineDate;
  final String description;
  final List<TechnologyStack> technologyStack;
  final List<String> teamRoles;
  final String organizationId;
  final String employeeIds;

  ProjectModel({
    required super.roles,
    required super.technologies,
    required super.id,
    required super.name,
    required this.period,
    required this.startDate,
    required this.deadlineDate,
    required this.description,
    required this.technologyStack,
    required this.teamRoles,
    required this.organizationId,
    required this.employeeIds,
    required super.projectManager,
  });

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'],
      name: map['name'],
      roles: List<String>.from(map['roles']),
      technologies: List<String>.from(map['technologies']),
      period: ProjectPeriodX.fromString(map['period']),
      startDate: (map['startDate'] as Timestamp).toDate(),
      deadlineDate: (map['deadlineDate'] as Timestamp).toDate(),
      description: map['description'],
      technologyStack: List<TechnologyStack>.from(
          map['technologyStack'].map((x) => TechnologyStack.fromMap(x))),
      teamRoles: List<String>.from(map['teamRoles']),
      organizationId: map['organizationId'],
      employeeIds: map['employeeIds'],
      projectManager: map['projectManager'],
    );
  }

  factory ProjectModel.fromJson(String source) =>
      ProjectModel.fromMap(json.decode(source));
}
