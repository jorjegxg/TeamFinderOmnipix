import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart';

@injectable
class DepartamentSkillsProvider extends ChangeNotifier {
  final DepartmentUseCase _departmentUseCase;
  DepartamentSkillsProvider(this._departmentUseCase);
  List<Skill> _skills = [];
  bool _isLoading = false;
  String _error = '';

  List<Skill> get skills => _skills;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchSkillsForDepartament(String departamentId) async {
    _isLoading = true;
    notifyListeners();
    (await _departmentUseCase.getSkillsForDepartament(departamentId)).fold(
      (l) {
        _error = l.message;
        _isLoading = false;
        notifyListeners();
      },
      (r) {
        _skills = r;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  //delete skill from departament
  Future<void> deleteSkillFromDepartament(
      String departamentId, String skillId) async {
    _isLoading = true;
    notifyListeners();
    (await _departmentUseCase.deleteSkillFromDepartament(
            departamentId, skillId))
        .fold(
      (l) {
        _error = l.message;
        _isLoading = false;
        notifyListeners();
      },
      (r) {
        // _skills.removeWhere((element) => element.id == skillId);
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
