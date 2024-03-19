import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart';

@injectable
class CreateSkillProvider extends ChangeNotifier {
  final DepartmentUseCase _departmentUseCase;

  CreateSkillProvider(this._departmentUseCase);
  String _name = '';
  String _category = '';
  String _description = '';
  List<String> _categoriesSugestions = [];
  bool _isLoading = false;
  String? _error;

  String get name => _name;
  String get category => _category;
  String get description => _description;
  List<String> get categoriesSugestions => _categoriesSugestions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setCategorySugestions(List<String> categories) {
    _categoriesSugestions = categories;
    notifyListeners();
  }

  void setCategory(String category) {
    _category = category;
    notifyListeners();
  }

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  void clearCategory() {
    _category = '';
    notifyListeners();
  }

  Future<void> createSkill() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    Skill skill = Skill(
      name: _name,
      category: _category,
      description: _description,
      currentManager: '',
      id: '',
    );
    await _departmentUseCase.createSkill(skill: skill).then((value) {
      value.fold(
        (left) {
          _error = left.message;
          _isLoading = false;
          notifyListeners();
        },
        (right) {
          _isLoading = false;
          notifyListeners();
        },
      );
    });
  }

  Future<void> fetchCategoriesSugestions() async {
    _isLoading = true;
    notifyListeners();
    (await _departmentUseCase.getCategories()).fold(
      (l) {
        _error = l.message;
        _isLoading = false;
        notifyListeners();
      },
      (r) {
        _categoriesSugestions = r;
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
