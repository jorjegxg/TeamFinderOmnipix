import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/util/snack_bar.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart';

@injectable
class DepartamentSkillsProvider extends ChangeNotifier {
  final DepartmentUseCase _departmentUseCase;
  DepartamentSkillsProvider(this._departmentUseCase);
  List<Skill> _skills = List.from([]);
  Map<Skill, bool> _skillsNotInDepartament = {};
  bool _isLoading = false;
  String? _error;

  List<Skill> get skills => _skills;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<Skill, bool> get skillsNotInDepartament => _skillsNotInDepartament;

  //set skill bool
  void setSkillBool(Skill skill, bool value) {
    _skillsNotInDepartament[skill] = value;
    notifyListeners();
  }

  ///reset

  void reset() {
    _skills = List.from([]);
    _skillsNotInDepartament = {};
    _isLoading = false;
    _error = null;
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
        _skills = List.from(r);
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  //delete skill from departament
  Future<void> deleteSkillFromDepartament(
      BuildContext context, String departamentId, String skillId) async {
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
        skills.removeWhere((element) => element.id == skillId);

        showSnackBar(context, 'Skill deleted successfully');
        //  fetchSkillsForDepartament(departamentId);
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
            { for (var e in r) e : false };
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

  void clearAllData() {
    _skills = [];
    _skillsNotInDepartament = {};
    _isLoading = false;
    _error = null;
  }
}
