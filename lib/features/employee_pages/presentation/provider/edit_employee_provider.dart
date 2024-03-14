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
        }
        if (role.departmentManager) {
          _isEmployeeDepartmentManager = true;
        }
        if (role.projectManager) {
          _isEmployeeProjectManager = true;
        }

        _isLoading = false;
        notifyListeners();
      },
    );
  }

  // Future<void> switchRoleOrganizationAdmin({
  //   required String employeeId,
  //   required String organizationId,
  //   required bool isSwitchedToTrue,
  // }) async {
  //   _isLoading = true;
  //   notifyListeners();

  //   late Either<Failure<dynamic>, void> result;

  //   if (isSwitchedToTrue) {
  //     result = await _employeeUsecase.makeEmployeeOrganizationAdmin(
  //       employeeId: employeeId,
  //       organizationId: organizationId,
  //     );
  //   } else {
  //     result = await _employeeUsecase.takeOrganizationAdminRoleFromEmployee(
  //       employeeId: employeeId,
  //       organizationId: organizationId,
  //     );
  //   }

  //   result.fold(
  //     (l) {
  //       _errorMessage = l.message;
  //       _isLoading = false;
  //       notifyListeners();
  //     },
  //     (r) {
  //       _isEmployeeOrganizationAdmin = isSwitchedToTrue;
  //       _isLoading = false;
  //       notifyListeners();
  //     },
  //   );
  // }
}
