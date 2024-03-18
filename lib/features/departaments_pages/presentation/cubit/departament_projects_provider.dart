import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart';
import 'package:team_finder_app/features/project_pages/data/models/project_model.dart';

@injectable
class DepartamentProjectsProvider extends ChangeNotifier {
  // Add your provider logic here
  final DepartmentUseCase _departmentUseCase;

  DepartamentProjectsProvider(this._departmentUseCase);
  // Example property
  bool _isLoading = false;
  String? _error;
  List<ProjectModel> _projects = [];

  List<ProjectModel> get projects => _projects;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void addProject(ProjectModel project) {
    _projects.add(project);
    notifyListeners();
  }

  void removeProject(String project) {
    _projects.remove(project);
    notifyListeners();
  }

  Future<void> fetchProjectsForDepartament(String departamentId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result =
        await _departmentUseCase.getProjectsForDepartament(departamentId);
    result.fold((l) {
      _error = l.message;
      _isLoading = false;
      notifyListeners();
    }, (r) {
      _isLoading = false;
      _projects = r;
      notifyListeners();
    });
    // Add your logic here
  }
}
