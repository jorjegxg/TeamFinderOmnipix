import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart';

@injectable
class SkillStatisticsProvider extends ChangeNotifier {
  DepartmentUseCase _departmentUseCase;

  SkillStatisticsProvider(this._departmentUseCase);
  bool _isLoading = false;
  String? _error;
  List<Map<String, int>> _statistics = [];
  List<Skill> _skills = [];
  Skill? currentlySelected;

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Map<String, int>> get statistics => _statistics;
  List<Skill> get skills => _skills;
  Skill get currentlySelectedSkill => currentlySelected!;

  void updateTotalSkills(List<Map<String, int>> statistics) {
    _statistics = List.from(statistics);
    notifyListeners();
  }

  void updateCurrentlySelected(Skill skill) {
    currentlySelected = skill;
    notifyListeners();
  }

  void updateSkills(List<Skill> skills) {
    _skills = List.from(skills);
    notifyListeners();
  }
  //get Skills for departament

  Future<void> getSkills(String departamentId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result =
        await _departmentUseCase.getSkillsForDepartament(departamentId);
    result.fold((l) {
      _error = l.message;
      _isLoading = false;
      notifyListeners();
    }, (r) {
      _isLoading = false;
      updateSkills(r);
      updateCurrentlySelected(r.first);
    });
  }

  Future<void> fetchStatisticsForDepartament(
      String departamentId, String skillId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _departmentUseCase.getStatisticsForDepartament(
        departamentId, skillId);
    result.fold((l) {
      _error = l.message;
      _isLoading = false;
      notifyListeners();
    }, (r) {
      _isLoading = false;
      updateTotalSkills(r);
    });
  }
}
