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
  Map<String, int> _statistics = {};
  List<Skill> _skills = [];
  Skill? currentlySelected;

  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, int> get statistics => _statistics;
  List<Skill> get skills => _skills;
  Skill get currentlySelectedSkill => currentlySelected!;

  void updateCurrentlySelected(Skill skill) {
    currentlySelected = skill;
    notifyListeners();
  }

  void updateSkills(List<Skill> skills) {
    _skills = List.from(skills);
    notifyListeners();
  }
  //get Skills for departament

  //total count
  //total count of employees with that skill

  int getTotalCount() {
    int sum = 0;
    for (var val in _statistics.values) {
      sum += val;
    }
    return sum;
  }

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
    }, (r) async {
      updateSkills(r);
      updateCurrentlySelected(r.first);
      await fetchStatisticsForDepartament(departamentId);
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> fetchStatisticsForDepartament(String departamentId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _departmentUseCase.getStatisticsForDepartament(
        departamentId, currentlySelected!.id);
    result.fold((l) {
      _error = l.message;
      _isLoading = false;
      notifyListeners();
    }, (r) {
      _isLoading = false;
      _statistics = Map.from(r);
      notifyListeners();
    });
  }
}
