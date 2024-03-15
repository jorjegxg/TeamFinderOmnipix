import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/features/employee_pages/data/employee_repo_impl.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee_roles.dart';

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

  Future<Either<Failure, EmployeesRoles>> getEmployeeRoles(String employeeId) {
    return employeeRepoImpl.getEmployeeRoles(employeeId);
  }

  Future<Either<Failure, void>> takeOrganizationAdminRoleFromEmployee(
      {required String employeeId, required String organizationId}) {
    return employeeRepoImpl.takeOrganizationAdminRoleFromEmployee(
      employeeId: employeeId,
      organizationId: organizationId,
    );
  }

  Future<Either<Failure, void>> updateEmployeeRoles(
      {required String employeeId,
      bool? admin,
      bool? departmentManager,
      bool? projectManager}) async {
    if (admin != null) {
      if (admin) {
        await employeeRepoImpl.makeEmployeeOrganizationAdmin(employeeId);
      } else {
        // return employeeRepoImpl
        //     .takeOrganizationAdminRoleFromEmployee(employeeId);
      }
    }

    if (departmentManager != null) {
      if (departmentManager) {
        await employeeRepoImpl.makeEmployeeDepartmentManager(employeeId);
      } else {
        // return employeeRepoImpl
        //     .takeDepartmentManagerRoleFromEmployee(employeeId);
      }
    }

    if (projectManager != null) {
      if (projectManager) {
        await employeeRepoImpl.makeEmployeeProjectManager(employeeId);
      } else {
        return employeeRepoImpl
            .deleteProjectManagerRoleFromEmployee(employeeId);
      }
    }

    return right(null);
  }
}
