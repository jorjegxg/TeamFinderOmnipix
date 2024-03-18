import 'package:flutter/material.dart';
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart';

class ConfirmationSkillsProvider extends ChangeNotifier {
  // Add your provider logic here
  final DepartmentUseCase _departmentUseCase;
  ConfirmationSkillsProvider(this._departmentUseCase);
  // List<> _allocations = [];
  //List<> _dealocations = [];

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getConfirmations(String departamentId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    // final result = await _departmentUseCase.getConfirmations(departamentId);
    // result.fold((l) {
    //   _error = l.message;
    //   _isLoading = false;
    //   notifyListeners();
    // }, (r) {
    //   _isLoading = false;
    // });
  }
}
