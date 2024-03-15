import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/features/employee_pages/domain/employee_usecase.dart';

@injectable
class EditEmployeeProvider extends ChangeNotifier {
  EditEmployeeProvider(this._employeeUsecase);
  final EmployeeUsecase _employeeUsecase;
  bool _isEmployeeOrganizationAdmin = false;
  bool _isEmployeeDepartmentManager = false;
  bool _isEmployeeProjectManager = false;

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

  Future<void> getEmployeeRoles(String employeeId) async {
    _isLoading = true;
    notifyListeners();

    final result = await _employeeUsecase.getEmployeeRoles(employeeId);

    result.fold(
      (l) {
        _errorMessage = l.message;
        _isLoading = false;
        notifyListeners();
      },
      (role) {
        if (role.admin) {
          _isEmployeeOrganizationAdmin = true;
          _defaultIsEmployeeOrganizationAdmin = true;
        }
        if (role.departmentManager) {
          _isEmployeeDepartmentManager = true;
          _defaultIsEmployeeDepartmentManager = true;
        }
        if (role.projectManager) {
          _isEmployeeProjectManager = true;
          _defaultIsEmployeeProjectManager = true;
        }

        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<Either<Failure<dynamic>, void>> saveChanges(String employeeId) async {
    _isLoading = true;
    notifyListeners();

    return (await _employeeUsecase.updateEmployeeRoles(
      employeeId: employeeId,
      admin: _isEmployeeOrganizationAdmin != _defaultIsEmployeeOrganizationAdmin
          ? _isEmployeeOrganizationAdmin
          : null,
      departmentManager:
          _isEmployeeDepartmentManager != _defaultIsEmployeeDepartmentManager
              ? _isEmployeeDepartmentManager
              : null,
      projectManager:
          _isEmployeeProjectManager != _defaultIsEmployeeProjectManager
              ? _isEmployeeProjectManager
              : null,
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
}
