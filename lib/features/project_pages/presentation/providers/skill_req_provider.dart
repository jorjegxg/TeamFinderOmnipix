import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';
import 'package:team_finder_app/features/project_pages/domain/usecases/projects_usecase.dart';

@injectable
class SkillReqProvider extends ChangeNotifier {
  final ProjectsUsecase _projectsUsecase;

  SkillReqProvider(this._projectsUsecase);

  bool _isLoading = false;
  String? _error;
  final Map<Map<Skill, int>, bool> _skills = {};

  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<Map<Skill, int>, bool> get skills => _skills;

  //set skill bool
  void setSkillBool(Map<Skill, int> skill, bool value) {
    _skills.update(skill, (v) => value);
    notifyListeners();
  }

  Future<void> fetchSkills() async {
    _isLoading = true;
    notifyListeners();
    (await _projectsUsecase.getSkills()).fold(
      (l) {
        _error = l.message;
        _isLoading = false;
        notifyListeners();
      },
      (r) {
        for (var skill in r) {
          _skills.putIfAbsent({skill: 0}, () => false);
        }
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  //set skill int
  void setSkillInt(Map<Skill, int> skill, int value) {
    for (var entry in _skills.entries) {
      if (entry.key == skill) {
        entry.key.update(
          entry.key.keys.first,
          (v) => value,
        );
      }
    }
    notifyListeners();
  }

  //post skill req
  Future<void> postSkillReq(String projectId) async {
    _isLoading = true;
    notifyListeners();
    final selectedSkills = _skills.entries
        .where((element) => element.value)
        .map((e) => e.key)
        .toList();
    for (var skill in selectedSkills) {
      (await _projectsUsecase.postSkillReq(
        projectId: projectId,
        skill: {
          skill.keys.first.id: skill.values.first,
        },
      ))
          .fold(
        (l) {
          _error = l.message;
          _isLoading = false;
          notifyListeners();
        },
        (r) {
          _isLoading = false;
          notifyListeners();
        },
      );
    }
  }
}
