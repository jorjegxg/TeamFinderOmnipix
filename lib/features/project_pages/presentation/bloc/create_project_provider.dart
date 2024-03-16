// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/core/util/logger.dart';
import 'package:team_finder_app/features/project_pages/data/models/project_model.dart';
import 'package:team_finder_app/features/project_pages/data/models/technology_stack.dart';

import 'package:team_finder_app/features/project_pages/domain/usecases/projects_usecase.dart';

@injectable
class CreateProjectProvider extends ChangeNotifier {
  final ProjectsUsecase _projectsUsecase;
  String name = '';
  bool _isLoading = false;
  String? _error;
  ProjectPeriod period = ProjectPeriod.fixed;
  ProjectStatus status = ProjectStatus.NotStarted;
  DateTime startDate = DateTime.now();
  DateTime deadlineDate = DateTime.now();
  String description = '';
  Map<Map<String, int>, bool> teamRoles = {
    {'Developer': 0}: false,
    {'Designer': 0}: false,
    {'Tester': 0}: false,
    {'Project Manager': 0}: false,
  };
  List<TechnologyStack> technologyStack = [];
  List<TechnologyStack> sugestions = [
    TechnologyStack(name: 'Flutter', id: ''),
    TechnologyStack(name: 'Dart', id: ''),
  ];

  bool get isLoading => _isLoading;
  String? get error => _error;
  String get getName => name;
  ProjectPeriod get getPeriod => period;
  ProjectStatus get getStatus => status;
  DateTime get getStartDate => startDate;
  DateTime get getDeadlineDate => deadlineDate;
  String get getDescription => description;
  Map<Map<String, int>, bool> get getteamRoles => teamRoles;
  List<TechnologyStack> get getTechnologyStack => technologyStack;
  List<TechnologyStack> get getSugestions => sugestions;

  void setName(String value) {
    name = value;
    notifyListeners();
  }

  void setPeriod(ProjectPeriod value) {
    period = value;
    notifyListeners();
  }

  void setStatus(ProjectStatus value) {
    status = value;
    notifyListeners();
  }

  void setStartDate(DateTime value) {
    startDate = value;
    notifyListeners();
  }

  void setDeadlineDate(DateTime value) {
    deadlineDate = value;
    notifyListeners();
  }

  void setDescription(String value) {
    description = value;
    notifyListeners();
  }

  void setTeamRoles(int index, bool value, int number) {
    Logger.info('prov', 'index: $index, value: $value');
    teamRoles[teamRoles.keys.elementAt(index)] = value;
    teamRoles.keys.elementAt(index).update(
          teamRoles.keys.elementAt(index).keys.first,
          (value) => number,
        );
    notifyListeners();
  }

  void setSuggestions(List<TechnologyStack> value) {
    sugestions = value;
    notifyListeners();
  }

  void addTechnology(String value) {
    bool isExist = false;
    for (var element in sugestions) {
      if (element.name == value) {
        technologyStack.add(element);
        isExist = true;
        sugestions.remove(element);
        break;
      }
    }
    if (!isExist) {
      technologyStack.add(TechnologyStack(name: value, id: ''));
    }

    notifyListeners();
  }

  void removeTechnology(TechnologyStack technology) {
    technologyStack.remove(technology);
    sugestions.add(technology);
    notifyListeners();
  }

  CreateProjectProvider(this._projectsUsecase);

  Future<void> createProject() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    Map<String, int> teamRolesMap = {};

    teamRoles.forEach((key, value) {
      if (value) {
        teamRolesMap.addAll(key);
      }
    });

    final ProjectModel project = ProjectModel(
      id: Random().nextInt(1000).toString(),
      name: name,
      period: period,
      startDate: startDate,
      deadlineDate: deadlineDate,
      description: description,
      technologyStack: technologyStack,
      teamRoles: teamRolesMap,
      organizationId: '',
      status: status.toStringValue(),
      projectManager: '1',
    );
    await _projectsUsecase.createProject(newProject: project).then((result) {
      result.fold(
        (left) {
          _error = left.message;
          _isLoading = false;
          notifyListeners();
        },
        (right) {
          _isLoading = false;
          removeData();
          notifyListeners();
        },
      );
    });
  }

  void removeData() {
    name = '';
    _isLoading = false;
    _error = null;
    period = ProjectPeriod.fixed;
    status = ProjectStatus.NotStarted;
    startDate = DateTime.now();
    deadlineDate = DateTime.now();
    description = '';
    teamRoles = {};
    technologyStack = [];
    sugestions = [];
  }
}
