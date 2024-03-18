import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee_roles_and_data.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee_model.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee_roles.dart';

@injectable
class EmployeeRepoImpl {
  Future<String> getOrganizationId() async {
    final box = Hive.box<String>(HiveConstants.authBox);
    return box.get(HiveConstants.organizationId)!;
  }

  Future<String> getEmployeeId() async {
    final box = Hive.box<String>(HiveConstants.authBox);
    return box.get(HiveConstants.userId)!;
  }

  Future<Either<Failure, List<Employee>>> getEmployees() async {
    final organizationId = await getOrganizationId();
    return ApiService().dioGet(
      url:
          "${EndpointConstants.baseUrl}/employee/organizationemployees/$organizationId",
      codeMessage: {
        404: "No employees found",
      },
    ).then((response) {
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

  Future<Either<Failure, void>> demoteAdmin(
      {required String employeeId}) async {
    final currentUserId = await getEmployeeId();

    if (currentUserId == employeeId) {
      return left(
          EasyFailure(message: "You can't demote yourself from admin role"));
    }

    return ApiService()
        .dioDelete(
      url:
          "${EndpointConstants.baseUrl}/admin/demoteorganizationadmin/$employeeId",
    )
        .then((response) {
      return response.fold(
        (l) => left(l),
        (r) => right(null),
      );
    });
  }

  //make employee department manager
  Future<Either<Failure, void>> makeEmployeeDepartmentManager(
      String newManagerId) async {
    final organizationId = await getOrganizationId();
    return ApiService().dioPost(
      url: "${EndpointConstants.baseUrl}/departamentpromotion/",
      data: {
        "organizationId": organizationId,
        "employeeId": newManagerId,
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

  Future<Either<Failure, EmployeesRoles>> _getEmployeeRoles(String employeeId) {
    return ApiService().dioGet(
      url: "${EndpointConstants.baseUrl}/employee/roles/$employeeId",
      codeMessage: {
        404: "No roles found",
      },
    ).then((response) {
      return response.fold(
        (l) => left(l),
        (r) {
          final EmployeesRoles employeesRoles = EmployeesRoles.fromJson(r);

          return right(employeesRoles);
        },
      );
    });
  }

  Future<Either<Failure, EmployeeModel>> _getEmployeeData(String employeeId) {
    return ApiService().dioGet(
      url: "${EndpointConstants.baseUrl}/employee/info/$employeeId",
      codeMessage: {
        404: "No data found",
      },
    ).then((response) {
      return response.fold(
        (l) => left(l),
        (r) {
          final EmployeeModel employee = EmployeeModel.fromJson(r);
          return right(employee);
        },
      );
    });
  }

  Future<Either<Failure, EmployeeRolesAndData>> getEmployeeRolesAndData(
      String employeeId) async {
    final employeeRoles = await _getEmployeeRoles(employeeId);
    final employeeData = await _getEmployeeData(employeeId);

    return employeeRoles.fold(
      (l) => left(l),
      (employeeRoles) {
        return employeeData.fold(
          (l) => left(l),
          (employeeData) {
            return right(
              EmployeeRolesAndData(
                employeesRoles: employeeRoles,
                employeeModel: employeeData,
              ),
            );
          },
        );
      },
    );
  }

  Future<Either<Failure, void>> updateEmployeeRoles({
    required String employeeId,
    required bool admin,
    required bool departmentManager,
    required bool projectManager,
  }) async {
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

  Future<Either<Failure, void>> deleteProjectManagerRoleFromEmployee(
      String employeeId) async {
    return ApiService()
        .dioDelete(
      url:
          "${EndpointConstants.baseUrl}/projectmanager/demoteprojectmanager/$employeeId",
    )
        .then((response) {
      return response.fold(
        (l) => left(l),
        (r) => right(null),
      );
    });
  }

  Future<Either<Failure, void>> deleteDepartmentManagerRoleFromEmployee(
      String employeeId) async {
    return ApiService()
        .dioDelete(
      url:
          "${EndpointConstants.baseUrl}/departamentmanager/demotedepartamentmanager/$employeeId",
    )
        .then((response) {
      return response.fold(
        (l) => left(l),
        (r) => right(null),
      );
    });
  }

  //departament/updatemanager
  Future<Either<Failure, void>> updateMangerForDepartmentManager(
      String employeeId, String departmentId) async {
    return ApiService().dioPut(
      url: "${EndpointConstants.baseUrl}/departament/updatemanager",
      data: {
        "employeeId": employeeId,
        "departamentId": departmentId,
      },
    ).then((response) {
      return response.fold(
        (l) => left(l),
        (r) => right(null),
      );
    });
  }
}
