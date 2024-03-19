import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/util/snack_bar.dart';
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';

@injectable
class DepartamentEmployeesProvider extends ChangeNotifier {
  final DepartmentUseCase _departmentUseCase;
  List<Employee> _employees = [];
  bool _isLoading = false;
  String? _error;

  DepartamentEmployeesProvider(this._departmentUseCase);

  List<Employee> get employees => _employees;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchEmployeesForDepartments(String departamentId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result =
        await _departmentUseCase.getDepartamentEmployees(departamentId);
    result.fold(
      (left) {
        _error = left.message;
        _isLoading = false;
        notifyListeners();
      },
      (right) {
        _employees = List.from(right);
        _isLoading = false;
        notifyListeners();
      },
    );
    notifyListeners();
  }

  //remove employee from department
  Future<void> removeEmployeeFromDepartment(
      BuildContext context, String employeeId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result =
        await _departmentUseCase.removeEmployeeFromDepartment(employeeId);
    result.fold(
      (left) {
        _error = left.message;
        _isLoading = false;
        notifyListeners();
      },
      (right) {
        _employees.removeWhere((element) => element.id == employeeId);
        _isLoading = false;
        showSnackBar(context, 'Employee removed from department');
        notifyListeners();
      },
    );
    notifyListeners();
  }

  // Future<void> assignSkillDirectly(Employee employee){
  //   _isLoading = true;
  //   _error = null;
  //   notifyListeners();

  //   final result = _departmentUseCase.assignSkillDirectly(employee);
  //   result.fold(
  //     (left) {
  //       _error = left.message;
  //       _isLoading = false;
  //       notifyListeners();
  //     },
  //     (right) {
  //       _isLoading = false;
  //       notifyListeners();
  //     },
  //   );
  //   notifyListeners();
  // }
}
