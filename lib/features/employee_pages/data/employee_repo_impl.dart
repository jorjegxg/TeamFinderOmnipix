import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee_roles.dart';

@injectable
class EmployeeRepoImpl {
  Future<String> getOrganizationId() async {
    final box = Hive.box<String>(HiveConstants.authBox);
    return box.get(HiveConstants.organizationId)!;
  }

  Future<Either<Failure, List<Employee>>> getEmployees() async {
    final organizationId = await getOrganizationId();
    return ApiService()
        .dioGet(
      url:
          "${EndpointConstants.baseUrl}/employee/organizationemployees/$organizationId",
    )
        .then((response) {
      return response.fold(
        (l) => left(l),
        (r) {
          final List<Employee> employees = [];
          for (var employee in r) {
            employees.add(Employee.fromJson(employee));
          }
          return right(employees);
        },
      );
    });
  }

  // make employee organization admin
  ///admin/promoteadmin/{employeeId}/{organizationId}
  Future<Either<Failure, void>> makeEmployeeOrganizationAdmin(
    String employeeId,
  ) async {
    final organizationId = await getOrganizationId();
    return ApiService()
        .dioPut(
      url:
          "${EndpointConstants.baseUrl}/admin/promoteadmin/$employeeId/$organizationId",
    )
        .then((response) {
      return response.fold(
        (l) => left(l),
        (r) => right(null),
      );
    });
  }

  //delete la organization admin:
  //
  //---trebuie facuta
  Future<Either<Failure, void>> takeOrganizationAdminRoleFromEmployee(
      {required String employeeId, required String organizationId}) async {
    //TODO George Luta : implement this method

    return right(null);
  }

  //make employee department manager
  Future<Either<Failure, void>> makeEmployeeDepartmentManager(
      String employeeId) async {
    final organizationId = await getOrganizationId();
    return ApiService().dioPost(
      url: "${EndpointConstants.baseUrl}/departamentpromotion/",
      data: {
        "organizationId": organizationId,
        "employeeId": employeeId,
      },
    ).then((response) {
      return response.fold(
        (l) => left(l),
        (r) => right(null),
      );
    });
  }

  //update la department manager:
  ///departament/updatemanager
  ///(atunci cand dau switch off -- trebuie sa aleg un nou manager)
  ///
  ///foloseste endpoinul de departament manageri care nu au departament
  /// departamentmanager/managersnodepartament/{id}
  ///
  /// o sa apara un dropdown
  ///
  ///
  /// foloseste si noul endpoint
  ///

  //make employee project manager
  Future<Either<Failure, void>> makeEmployeeProjectManager(
    String employeeId,
  ) async {
    return ApiService()
        .dioPost(
      url:
          "${EndpointConstants.baseUrl}/projectmanager/createprojectmanager/$employeeId",
    )
        .then((response) {
      return response.fold(
        (l) => left(l),
        (r) => right(null),
      );
    });
  }

  //dealocate project manager
  //
  //---trebuie facuta

  //get employee roles
  Future<Either<Failure, EmployeesRoles>> getEmployeeRoles(String employeeId) {
    return ApiService()
        .dioGet(
      url: "${EndpointConstants.baseUrl}/employee/roles/$employeeId",
    )
        .then((response) {
      return response.fold(
        (l) => left(l),
        (r) {
          final EmployeesRoles employeesRoles = EmployeesRoles.fromJson(r);

          return right(employeesRoles);
        },
      );
    });
  }

  Future<Either<Failure, void>> updateEmployeeRoles(
      {required String employeeId,
      required bool admin,
      required bool departmentManager,
      required bool projectManager}) async {
    return ApiService().dioPost(
      url: "${EndpointConstants.baseUrl}/employee/updateroles/$employeeId",
      data: {
        "admin": admin,
        "departmentManager": departmentManager,
        "projectManager": projectManager,
      },
    ).then((response) {
      return response.fold(
        (l) => left(l),
        (r) => right(null),
      );
    });
  }
}
