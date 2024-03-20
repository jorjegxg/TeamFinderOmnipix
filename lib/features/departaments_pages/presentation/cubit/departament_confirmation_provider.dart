import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/alocation.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/dealocation.dart';
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart';

@injectable
class DepartamentConfirmationProvider extends ChangeNotifier {
  final DepartmentUseCase _departmentUseCase;

  DepartamentConfirmationProvider(this._departmentUseCase);

  List<Dealocation> _dealocations = List.from([]);
  bool _isLoading = false;
  String? _error = null;
  List<Alocation> _alocations = List.from([]);
  List<dynamic> _allItems = List.from([]);

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
        _allItems.clear();
        _dealocations = List.from(r);
        _allItems
          ..addAll(_alocations)
          ..addAll(_dealocations);
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
        _alocations = List.from(r);
        _allItems.clear();
        _allItems
          ..addAll(_alocations)
          ..addAll(_dealocations);
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  //accept/refuse
  Future<void> acceptDealocation(String id) async {
    _isLoading = true;
    notifyListeners();
    (await _departmentUseCase.acceptDealocation(id)).fold(
      (l) {
        _error = l.message;
        _isLoading = false;
        notifyListeners();
      },
      (r) {
        _dealocations.removeWhere((element) => element.id == id);
        _allItems.removeWhere((element) => element.id == id);
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> refuseDealocation(String id) async {
    _isLoading = true;
    notifyListeners();
    (await _departmentUseCase.refuseDealocation(id)).fold(
      (l) {
        _error = l.message;
        _isLoading = false;
        notifyListeners();
      },
      (r) {
        // _dealocations.removeWhere((element) => element.id == id);
        _allItems.removeWhere((element) => element.id == id);
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> acceptAlocation(String id) async {
    _isLoading = true;
    notifyListeners();
    (await _departmentUseCase.acceptAlocation(id)).fold(
      (l) {
        _error = l.message;
        _isLoading = false;
        notifyListeners();
      },
      (r) {
        _alocations.removeWhere((element) => element.id == id);
        _allItems.removeWhere((element) => element.id == id);
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> refuseAlocation(String id) async {
    _isLoading = true;
    notifyListeners();
    (await _departmentUseCase.refuseAlocation(id)).fold(
      (l) {
        _error = l.message;
        _isLoading = false;
        notifyListeners();
      },
      (r) {
        _alocations.removeWhere((element) => element.id == id);
        _allItems.removeWhere((element) => element.id == id);
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
