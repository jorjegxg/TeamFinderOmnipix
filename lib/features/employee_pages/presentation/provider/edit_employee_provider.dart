import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/core/util/logger.dart';
import 'package:team_finder_app/features/auth/data/models/manager.dart';
import 'package:team_finder_app/features/employee_pages/data/models/manager_and_department_id.dart';
import 'package:team_finder_app/features/employee_pages/domain/employee_usecase.dart';

@injectable
class EditEmployeeProvider extends ChangeNotifier {
  EditEmployeeProvider(this._employeeUsecase);
  final EmployeeUsecase _employeeUsecase;
  bool _isEmployeeOrganizationAdmin = false;
  bool _isEmployeeDepartmentManager = false;
  bool _isEmployeeProjectManager = false;
  bool _hasDepartment = false;
  String? _departmentId;

  bool _defaultIsEmployeeOrganizationAdmin = false;
  bool _defaultIsEmployeeDepartmentManager = false;
  bool _defaultIsEmployeeProjectManager = false;

  bool _isLoading = false;
  String? _errorMessage;

  bool get isEmployeeOrganizationAdmin => _isEmployeeOrganizationAdmin;
  bool get isEmployeeDepartmentManager => _isEmployeeDepartmentManager;
  bool get isEmployeeProjectManager => _isEmployeeProjectManager;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasDepartment => _hasDepartment;

  Future<void> getEmployeeData(String employeeId) async {
    _isLoading = true;
    notifyListeners();

    final result = await _employeeUsecase.getEmployeeRolesAndData(employeeId);

    result.fold(
      (l) {
        _errorMessage = l.message;
        _isLoading = false;
        notifyListeners();
      },
      (emlRolesAndData) {
        _hasDepartment = emlRolesAndData.employeeModel.departamentId != null;
        _departmentId = emlRolesAndData.employeeModel.departamentId;

        Logger.warning('getEmployeeData',
            'departmentId: ${emlRolesAndData.employeeModel.departamentId}');

        //baga intr-o variabila employee-ul curent (sau doar departmentId)
        if (emlRolesAndData.employeesRoles.admin) {
          _isEmployeeOrganizationAdmin = true;
          _defaultIsEmployeeOrganizationAdmin = true;
        }
        if (emlRolesAndData.employeesRoles.departmentManager) {
          _isEmployeeDepartmentManager = true;
          _defaultIsEmployeeDepartmentManager = true;
        }
        if (emlRolesAndData.employeesRoles.projectManager) {
          _isEmployeeProjectManager = true;
          _defaultIsEmployeeProjectManager = true;
        }

        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<Either<Failure<dynamic>, void>> saveChanges(String employeeId,
      [Manager? newManager]) async {
    ///if you demote a department manager, you need to select a new one [ newManager != null]

    _isLoading = true;
    notifyListeners();

    return (await _employeeUsecase.updateEmployeeRoles(
      employeeId: employeeId,
      admin: _organizationAdminStatusHasChanged
          ? _isEmployeeOrganizationAdmin
          : null,
      departmentManager: _departmentManagerStatusHasChanged
          ? _isEmployeeDepartmentManager
          : null,
      projectManager:
          _projectManagerStatusHasChanged ? _isEmployeeProjectManager : null,
      managerAndDepartmentId: ManagerAndDepartmentId(
        newManager: newManager,
        departmentId: _departmentId,
      ),
      departmentManagerHasToBeChanged: departmentManagerHasToBeChanged,
    ))
        .fold(
      (l) {
        _errorMessage = l.message;
        _isLoading = false;
        notifyListeners();
        return left(l);
      },
      (r) {
        _isLoading = false;
        notifyListeners();
        return right(r);
      },
    );
  }

  bool get _projectManagerStatusHasChanged =>
      _isEmployeeProjectManager != _defaultIsEmployeeProjectManager;

  bool get _departmentManagerStatusHasChanged =>
      _isEmployeeDepartmentManager != _defaultIsEmployeeDepartmentManager;

  bool get _organizationAdminStatusHasChanged =>
      _isEmployeeOrganizationAdmin != _defaultIsEmployeeOrganizationAdmin;

  void changeOrganizationAdmin(bool value) {
    _isEmployeeOrganizationAdmin = value;
    notifyListeners();
  }

  void changeDepartmentManager(bool value) {
    _isEmployeeDepartmentManager = value;
    notifyListeners();
  }

  void changeProjectManager(bool value) {
    _isEmployeeProjectManager = value;
    notifyListeners();
  }

  bool get departmentManagerHasToBeChanged {
    return (departmenManagerStatusHasChanged &&
            _isEmployeeDepartmentManager == false) &&
        _hasDepartment;

    //daca 1.E demis manager de departament si 2.Are departament => arata dropdown (pentru a selecta un nou manager)
  }

  bool get departmenManagerStatusHasChanged {
    return _isEmployeeDepartmentManager != _defaultIsEmployeeDepartmentManager;
  }
}
