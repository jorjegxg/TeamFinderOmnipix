import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/validation.dart';
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart';

@injectable
class ValidationProvider extends ChangeNotifier {
  final DepartmentUseCase _departmentUseCase;

  ValidationProvider(this._departmentUseCase);

  bool _isLoading = false;
  String? _error;

  List<Validation> _allItems = [];

  bool get isLoading => _isLoading;
  String? get error => _error;

  List<Validation> get allItems => _allItems;

  Future<void> fetchValidations(String departamentId) async {
    _isLoading = true;
    notifyListeners();
    (await _departmentUseCase.fetchValidation(departamentId)).fold(
      (l) {
        _error = l.message;
        _isLoading = false;
        notifyListeners();
      },
      (r) {
        _allItems = List.from(r);
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  //accept/refuze
  Future<void> acceptValidation(String validationId) async {
    _isLoading = true;
    notifyListeners();
    (await _departmentUseCase.acceptValidation(validationId)).fold(
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

  Future<void> refuseValidation(String validationId) async {
    _isLoading = true;
    notifyListeners();
    (await _departmentUseCase.refuseValidation(validationId)).fold(
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
