import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';

@injectable
class AddEmployeeToDepartamentProvider extends ChangeNotifier {
  final DepartmentUseCase _departmentUseCase;
  final List<Employee> _employees = [];
  final List<Employee> _checkedEmployees = [];
  bool _isLoading = false;
  String? _error;

  AddEmployeeToDepartamentProvider(this._departmentUseCase);

  List<Employee> get employees => _employees;
  List<Employee> get checkedEmployees => _checkedEmployees;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void addEmployee(Employee employee) {
    _checkedEmployees.add(employee);
    notifyListeners();
  }

  void removeEmployee(Employee employee) {
    _checkedEmployees.remove(employee);
    notifyListeners();
  }

  Future<void> fetchEmployeesForDepartments() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _departmentUseCase.getFreeEmployees();
    result.fold(
      (left) {
        _error = left.message;
        _isLoading = false;
        notifyListeners();
      },
      (right) {
        _employees.addAll(right);
        _isLoading = false;
        notifyListeners();
      },
    );
    notifyListeners();
  }

  //add employees to department
  Future<void> addEmployeesToDepartment(String departmentId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _departmentUseCase.addEmployeesToDepartment(
      departmentId: departmentId,
      employees: _checkedEmployees,
    );
    result.fold(
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
  }
}
