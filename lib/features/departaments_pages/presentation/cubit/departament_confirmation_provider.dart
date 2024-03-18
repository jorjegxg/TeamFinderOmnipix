import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/alocation.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/dealocation.dart';
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart';

@injectable
class DepartamentConfirmationProvider extends ChangeNotifier {
  DepartmentUseCase _departmentUseCase;

  DepartamentConfirmationProvider(this._departmentUseCase);

  List<Dealocation> _dealocations = [];
  bool _isLoading = false;
  String? _error = null;
  List<Alocation> _alocations = [];
  List<dynamic> _allItems = [];

  List<Dealocation> get dealocations => _dealocations;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Alocation> get alocations => _alocations;
  List<dynamic> get allItems => _allItems;

  Future<void> fetchDealocations(String departamentId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    (await _departmentUseCase.getDealocations(departamentId)).fold(
      (l) {
        _error = l.message;
        _isLoading = false;
        notifyListeners();
      },
      (r) {
        _dealocations = r;
        _allItems.addAll(r);
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> fetchAlocations(String departamentId) async {
    _isLoading = true;
    notifyListeners();
    (await _departmentUseCase.getAlocations(departamentId)).fold(
      (l) {
        _error = l.message;
        _isLoading = false;
        notifyListeners();
      },
      (r) {
        _allItems.addAll(r);
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
