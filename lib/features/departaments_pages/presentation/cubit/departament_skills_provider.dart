import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart';

@injectable
class DepartamentSkillsProvider extends ChangeNotifier {
  DepartmentUseCase _departmentUseCase;
  DepartamentSkillsProvider(this._departmentUseCase);
  List<Skill> _skills = [];
  Map<Skill, bool> _skillsNotInDepartament = {};
  bool _isLoading = false;
  String? _error = null;

  List<Skill> get skills => _skills;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<Skill, bool> get skillsNotInDepartament => _skillsNotInDepartament;

  //set skill bool
  void setSkillBool(Skill skill, bool value) {
    _skillsNotInDepartament[skill] = value;
    notifyListeners();
  }

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

  //fetch skills that are not in the departament
  Future<void> fetchSkillsNotInDepartament(String departamentId) async {
    _isLoading = true;
    notifyListeners();
    (await _departmentUseCase.getSkillsNotInDepartament(departamentId)).fold(
      (l) {
        _error = l.message;
        _isLoading = false;
        notifyListeners();
      },
      (r) {
        _skillsNotInDepartament =
            Map.fromIterable(r, key: (e) => e, value: (e) => false);
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  //add selected skills to departament
  Future<void> addSelectedSkillsToDepartament(String departamentId) async {
    _isLoading = true;
    notifyListeners();

    List<String> skillsIds = _skillsNotInDepartament.entries
        .where((element) => element.value)
        .map((e) => e.key.id)
        .toList();

    for (var skillId in skillsIds) {
      (await _departmentUseCase.assignSkillToDepartament(
              skillId: skillId, departamentId: departamentId))
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
