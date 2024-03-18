// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/core/util/logger.dart';
import 'package:team_finder_app/features/project_pages/data/models/project_model.dart';
import 'package:team_finder_app/features/project_pages/data/models/team_role.dart';
import 'package:team_finder_app/features/project_pages/data/models/technology_stack.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';

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

  Map<Map<TeamRole, int>, bool> teamRoles = {};
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

  CreateProjectProvider(this._projectsUsecase);

  Future<void> createProject() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    Map<TeamRole, int> teamRolesMap = {};

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

  //get team roles
  Future<void> getTeamRoles() async {
    _isLoading = true;
    _error = null;

    _projectsUsecase.getTeamRoles().then((result) {
      result.fold(
        (left) {
          _error = left.message;
          _isLoading = false;
          notifyListeners();
        },
        (right) {
          for (var role in right) {
            teamRoles.putIfAbsent({role: 0}, () => false);
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
    technologyStack = project.technologyStack;

    // for (var role in teamRoles.keys) {
    //   if (project.teamRoles.keys.contains(role.keys.first)) {
    //     teamRoles[role] = true;
    //     role.update(role.keys.first, (value) => project.teamRoles.!);
    //     //TODO: update the value of the role
    //   }
    // }
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

  // Future<void> test() {
  //   var box = Hive.box<String>(HiveConstants.authBox);
  //   String organizationId = box.get(HiveConstants.organizationId)!;
  //   return (ApiService()
  //       .dioPost(url: "${EndpointConstants.baseUrl}/openai/", data: {
  //     "content": "Give me best employees for a flask app",
  //     "organizationId": "Aa7xIWqSHdYrJX1KuqAY"
  //   })).then((value) {
  //     return value.fold(
  //       (l) => Left(l),
  //       (r) {
  //         Logger.info('prov', r.toString());
  //         return Right(r);
  //       },
  //     );
  //   });
  // }
}
