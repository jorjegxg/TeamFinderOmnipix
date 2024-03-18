import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/core/util/logger.dart';
import 'package:team_finder_app/features/employee_pages/data/employee_repo_impl.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee_roles_and_data.dart';
import 'package:team_finder_app/features/employee_pages/data/models/manager_and_department_id.dart';

@injectable
class EmployeeUsecase {
  final EmployeeRepoImpl employeeRepoImpl;

  EmployeeUsecase(this.employeeRepoImpl);

  Future<String> getOrganizationId() {
    return employeeRepoImpl.getOrganizationId();
  }

  Future<void> copyLink(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  Future<Either<Failure, List<Employee>>> getEmployees() {
    return employeeRepoImpl.getEmployees();
  }

  Future<Either<Failure, void>> makeEmployeeOrganizationAdmin({
    required String employeeId,
    required String organizationId,
  }) {
    return employeeRepoImpl.makeEmployeeOrganizationAdmin(
      employeeId,
    );
  }

  Future<Either<Failure, void>> makeEmployeeDepartmentManager(
      String employeeId) {
    return employeeRepoImpl.makeEmployeeDepartmentManager(employeeId);
  }

  Future<Either<Failure, void>> makeEmployeeProjectManager(String employeeId) {
    return employeeRepoImpl.makeEmployeeProjectManager(employeeId);
  }

  Future<Either<Failure, EmployeeRolesAndData>> getEmployeeRolesAndData(
      String employeeId) {
    return employeeRepoImpl.getEmployeeRolesAndData(employeeId);
  }

  Future<Either<Failure, void>> demoteAdmin(
      {required String employeeId, required String organizationId}) {
    return employeeRepoImpl.demoteAdmin(
      employeeId: employeeId,
    );
  }

<<<<<<< HEAD
  /// admin , departmentManager, projectManager
  /// daca sunt null , nu se schimba nimic
  /// daca sunt false, se sterge rolul
  /// daca sunt true, se adauga rolul
  Future<Either<Failure, void>> updateEmployeeRoles({
    required String employeeId,
    bool? admin,
    bool? departmentManager,
    bool? projectManager,
    required ManagerAndDepartmentId managerAndDepartmentId,
    required bool departmentManagerHasToBeChanged,
  }) async {
    if (_departmentManagerStatusHasChanged(departmentManager)) {
      if (departmentManager!) {
        await employeeRepoImpl.makeEmployeeDepartmentManager(
          employeeId,
        );
      } else {
        if (departmentManagerHasToBeChanged) {
          //atunci schimba-l

          //daca nu a selectat un nou manager (din dropdown)
          if (managerAndDepartmentId.newManager == null) {
            return left(
              FieldFailure(
                message: 'You need to select a new manager',
              ),
            );
          } else {
            Logger.info('gfseg',
                'managerAndDepartmentId.departmentId : ${managerAndDepartmentId.departmentId}');
            await employeeRepoImpl.updateMangerForDepartmentManager(
                managerAndDepartmentId.newManager!.id,
                managerAndDepartmentId.departmentId!);
          }
        } else {
          await employeeRepoImpl.deleteDepartmentManagerRoleFromEmployee(
            employeeId,
          );
        }
      }
    }

    if (_projectManagerStatusHsChanged(projectManager)) {
      if (projectManager!) {
=======
  Future<Either<Failure, void>> updateEmployeeRoles(
      {required String employeeId,
      bool? admin,
      bool? departmentManager,
      bool? projectManager}) async {
    if (departmentManager != null) {
      if (departmentManager) {
        await employeeRepoImpl.makeEmployeeDepartmentManager(employeeId);
      } else {
        // await employeeRepoImpl
        //     .takeDepartmentManagerRoleFromEmployee(employeeId);
      }
    }

    if (projectManager != null) {
      if (projectManager) {
>>>>>>> 474d3f566a4c788ddf0a9290c298aec3089c1752
        await employeeRepoImpl.makeEmployeeProjectManager(employeeId);
      } else {
        await employeeRepoImpl.deleteProjectManagerRoleFromEmployee(employeeId);
      }
    }

<<<<<<< HEAD
    if (_adminStatusHasChanged(admin)) {
      if (admin!) {
=======
    if (admin != null) {
      if (admin) {
>>>>>>> 474d3f566a4c788ddf0a9290c298aec3089c1752
        await employeeRepoImpl.makeEmployeeOrganizationAdmin(employeeId);
      } else {
        return employeeRepoImpl.demoteAdmin(employeeId: employeeId);
      }
    }

    return right(null);
  }

  bool _adminStatusHasChanged(bool? admin) => admin != null;

  bool _projectManagerStatusHsChanged(bool? projectManager) =>
      projectManager != null;

  bool _departmentManagerStatusHasChanged(bool? departmentManager) =>
      departmentManager != null;
}
