// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/core/util/logger.dart';
import 'package:team_finder_app/features/project_pages/data/models/team_role.dart';
import 'package:team_finder_app/features/project_pages/data/models/technology_stack.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';

import 'package:team_finder_app/features/project_pages/domain/usecases/projects_usecase.dart';

@injectable
class EditProjectProvider extends ChangeNotifier {
  final ProjectsUsecase _projectsUsecase;
  String name = '';
  bool _isLoading = true;
  String? _error;
  ProjectPeriod period = ProjectPeriod.fixed;
  ProjectStatus status = ProjectStatus.NotStarted;
  DateTime startDate = DateTime.now();
  DateTime deadlineDate = DateTime.now();
  String description = '';

  Map<Map<TeamRole, int>, bool> teamRoles = {};
  List<TechnologyStack> technologyStack = [];
  List<TechnologyStack> sugestions = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  String get getName => name;
  ProjectPeriod get getPeriod => period;
  ProjectStatus get getStatus => status;
  DateTime get getStartDate => startDate;
  DateTime get getDeadlineDate => deadlineDate;
  String get getDescription => description;
  Map<Map<TeamRole, int>, bool> get getteamRoles => teamRoles;
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

  Future<void> fetchTechnologyStack() async {
    _isLoading = true;
    _error = null;
    sugestions = [];
    notifyListeners();
    await _projectsUsecase.getTechnologyStack().then((result) {
      result.fold(
        (left) {
          _error = left.message;
          _isLoading = false;
          notifyListeners();
        },
        (right) {
          //avoid duplicate technology by name
          for (var tech in right) {
            bool contains = false;
            for (var tech2 in sugestions) {
              if (tech.name == tech2.name) {
                contains = true;
              }
            }
            if (!contains) {
              sugestions.add(tech);
            }
          }
          _isLoading = false;
          notifyListeners();
        },
      );
    });

    notifyListeners();
  }

  EditProjectProvider(this._projectsUsecase);

  //get team roles
  Future<void> getTeamRoles() async {
    _isLoading = true;
    _error = null;
    teamRoles = {};

    await _projectsUsecase.getTeamRoles().then((result) {
      result.fold(
        (left) {
          _error = left.message;
          _isLoading = false;
          notifyListeners();
        },
        (right) {
          for (var role in right) {
            if (!teamRoles.keys.contains(role)) {
              teamRoles.putIfAbsent({role: 0}, () => false);
            }
          }
          _isLoading = false;
          notifyListeners();
        },
      );
    });

    notifyListeners();
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

  //fill the form with project data
  void fillForm(ProjectEntity project) {
    name = project.name;
    period = project.period;
    status = ProjectStatusX.fromString(project.status);
    startDate = project.startDate;
    deadlineDate = project.deadlineDate;
    description = project.description;
    technologyStack = List.from(project.technologyStack);
    List<TechnologyStack> temp = [];
    for (var tech in project.technologyStack) {
      for (var tech2 in sugestions) {
        if (tech.name != tech2.name) {
          temp.add(tech2);
        }
      }
    }
    sugestions = List.from(temp);
    for (var role in project.teamRoles.entries) {
      for (var key in teamRoles.keys) {
        if (role.key.name == key.keys.first.name) {
          teamRoles[key] = true;
          key.update(key.keys.first, (value) => role.value);
        }
      }
    }
    notifyListeners();
  }

  //edit project
  Future<void> editProject(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    Map<TeamRole, int> teamRolesMap = {};

    teamRoles.forEach((key, value) {
      if (value) {
        teamRolesMap.addAll(key);
      }
    });

    final ProjectEntity project = ProjectEntity(
      id: id,
      name: name,
      period: period,
      startDate: startDate,
      deadlineDate: deadlineDate,
      description: description,
      technologyStack: technologyStack,
      teamRoles: teamRolesMap,
      status: status.toStringValue(),
      projectManager: '1',
    );
    await _projectsUsecase.editProject(editedProject: project).then((result) {
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

  //delete project
  Future<void> deleteProject(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    await _projectsUsecase.deleteProject(projectId: id).then((result) {
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

  void clearAllData() {
    name = '';
    _isLoading = true;
    _error = null;
    period = ProjectPeriod.fixed;
    status = ProjectStatus.NotStarted;
    startDate = DateTime.now();
    deadlineDate = DateTime.now();
    description = '';
    teamRoles = {};
    technologyStack = [];
    sugestions = [];
    notifyListeners();
  }
}
