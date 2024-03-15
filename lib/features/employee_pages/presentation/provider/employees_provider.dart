import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';
import 'package:team_finder_app/features/employee_pages/domain/employee_usecase.dart';

@injectable
class EmployeesProvider extends ChangeNotifier {
  final EmployeeUsecase _employeeUsecase;
  List<Employee> _employees = [];
  bool _isLoading = false;
  String? _error;

  EmployeesProvider(this._employeeUsecase);

  List<Employee> get employees => _employees;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchEmployees() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _employeeUsecase.getEmployees();
    result.fold(
      (left) {
        _error = left.message;
        _isLoading = false;
        notifyListeners();
      },
      (right) {
        _employees = right;
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
