import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/util/logger.dart';
import 'package:team_finder_app/features/employee_pages/domain/employee_usecase.dart';

@singleton
class EmployeeRolesProvider extends ChangeNotifier {
  final EmployeeUsecase employeeUsecase;

  bool _isOrganizationAdmin = false;
  bool _isDepartmentManager = false;
  bool _isProjectManager = false;

  bool _isLoading = false;

  EmployeeRolesProvider(this.employeeUsecase);

  bool get isOrganizationAdmin => _isOrganizationAdmin;
  bool get isDepartmentManager => _isDepartmentManager;
  bool get isProjectManager => _isProjectManager;

  bool get isLoading => _isLoading;

  Future<void> getCurrentEmployeeRoles() async {
    final result = await employeeUsecase.getCurrentEmployeeRoles();
    return result.fold(
      (l) {
        Logger.error('getCurrentEmployeeRoles ', l.message);
        _isLoading = false;
      },
      (roles) {
        Logger.info('getCurrentEmployeeRoles (provider)', 'roles: $roles');

        _isOrganizationAdmin = roles.admin;
        _isDepartmentManager = roles.departmentManager;
        _isProjectManager = roles.projectManager;

        _isLoading = false;
        Logger.info('getCurrentEmployeeRoles (provider2)',
            'roles: $_isOrganizationAdmin $_isDepartmentManager $_isProjectManager');

        notifyListeners();
      },
    );
  }

  //setters
  void setIsOrganizationAdmin(bool value) {
    _isOrganizationAdmin = value;
    notifyListeners();
  }

  void setIsDepartmentManager(bool value) {
    _isDepartmentManager = value;
    notifyListeners();
  }

  void setIsProjectManager(bool value) {
    _isProjectManager = value;
    notifyListeners();
  }

  void clearAllData() {
    _isOrganizationAdmin = false;
    _isDepartmentManager = false;
    _isProjectManager = false;
    _isLoading = false;
    notifyListeners();
  }
}
