import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';

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
}
