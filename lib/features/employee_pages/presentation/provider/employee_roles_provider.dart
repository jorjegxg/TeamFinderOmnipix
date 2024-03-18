import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/core/util/logger.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee_roles.dart';
import 'package:team_finder_app/features/employee_pages/domain/employee_usecase.dart';

@injectable
class EmployeeRolesProvider extends ChangeNotifier {
  final EmployeeUsecase employeeUsecase;

  bool _isOrganizationAdmin = false;
  bool _isDepartmentManager = false;
  bool _isProjectManager = false;

  EmployeeRolesProvider(this.employeeUsecase);

  bool get isOrganizationAdmin => _isOrganizationAdmin;
  bool get isDepartmentManager => _isDepartmentManager;
  bool get isProjectManager => _isProjectManager;

  Future<void> getCurrentEmployeeRoles() async {
    final result = await employeeUsecase.getCurrentEmployeeRoles();
    return result.fold(
      (l) {
        Logger.error('getCurrentEmployeeRoles ', l.message);
      },
      (roles) {
        Logger.info('getCurrentEmployeeRoles (provider)', 'roles: $roles');
        if (roles.admin) {
          _isOrganizationAdmin = true;
        }
        if (roles.departmentManager) {
          _isDepartmentManager = true;
        }
        if (roles.projectManager) {
          _isProjectManager = true;
        }
        notifyListeners();
      },
    );
  }

  void resetRoles() {
    _isOrganizationAdmin = false;
    _isDepartmentManager = false;
    _isProjectManager = false;
    notifyListeners();
  }
}
