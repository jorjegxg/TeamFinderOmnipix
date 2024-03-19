import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';
import 'package:team_finder_app/features/settings/domain/usecases/settings_use_case.dart';

@singleton
class SkillAssignmentProvider extends ChangeNotifier {
  final SettingsUseCase _settingsUseCase;

  SkillAssignmentProvider(this._settingsUseCase);

  SkillLevel _skillLevel = SkillLevel.learns;
  ExperienceLevel _experienceLevel = ExperienceLevel.months0_6;
  Skill? selectedSkill;
  final List<Skill> _skills = [];
  bool _isLoading = false;
  String? _error;
  final List<Map<String, String>> _endorsmentsSkill = [];
  final List<String> _listOfProjects = [];

  SkillLevel get skillLevel => _skillLevel;
  ExperienceLevel get experienceLevel => _experienceLevel;
  List<Skill> get skills => _skills;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Skill? get getSelectedSkill => selectedSkill;
  List<Map<String, String>> get endorsmentsSkill => _endorsmentsSkill;

  set setExperienceLevel(ExperienceLevel value) {
    _experienceLevel = value;
    notifyListeners();
  }

  set skillLevel(SkillLevel value) {
    _skillLevel = value;
    notifyListeners();
  }

  void setSelectedSkill(String skillName) {
    selectedSkill = _skills.firstWhere((element) => element.name == skillName);
    notifyListeners();
  }

  void addEndorsment(String skillName, String description) {
    _endorsmentsSkill.add({
      " title": skillName,
      "description": description,
    });
    notifyListeners();
  }

  void removeEndorsment(String skillName, String userName) {
    _endorsmentsSkill.removeWhere((element) =>
        element.keys.first == skillName && element.values.first == userName);
    notifyListeners();
  }

  Future<void> addSkillToEmployee() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    await _settingsUseCase
        .addSkill(selectedSkill!.id, _skillLevel.toInt(),
            _experienceLevel.index, _endorsmentsSkill, _listOfProjects)
        .then((response) {
      response.fold(
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
    });
  }

  Future<void> getFreeSkills() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _settingsUseCase.getFreeSkills();
    result.fold(
      (l) {
        _error = l.message;
        _isLoading = false;
        notifyListeners();
      },
      (r) {
        //remove skills with same name
        for (var skill in r) {
          if (!_skills.any((element) => element.name == skill.name)) {
            _skills.add(skill);
          }
        }

        _isLoading = false;
        if (_skills.isNotEmpty) selectedSkill = _skills.first;
        notifyListeners();
      },
    );
  }
}
