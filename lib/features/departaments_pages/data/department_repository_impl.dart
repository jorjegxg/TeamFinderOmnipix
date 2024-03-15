import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/features/auth/data/models/manager.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/department.dart';

@injectable
class DepartmentRepositoryImpl {
  Future<Either<Failure<String>, String>> createDepartment({
    required String name,
  }) async {
    var box = Hive.box<String>(HiveConstants.authBox);
    String organizationId = box.get(HiveConstants.organizationId)!;

    return (await ApiService().dioPost(
      url: "${EndpointConstants.baseUrl}/departament/create",
      data: {
        "name": name,
        "organizationId": organizationId,
      },
    ))
        .fold(
      (l) => left(l),
      (r) => right(r['id']),
    );
  }

  Future<Either<Failure<String>, void>> assignManagerToDepartment({
    required String managerId,
    required String departmentId,
  }) async {
    return (ApiService().dioPut(
      url:
          "${EndpointConstants.baseUrl}/departament/firstpromotedepartamentmanager",
      data: {
        "employeeId": managerId,
        "departamentId": departmentId,
      },
    ));
  }

  Future<Either<Failure<String>, List<Manager>>> getDepartmentManagers() async {
    var box = Hive.box<String>(HiveConstants.authBox);
    String organizationId = box.get(HiveConstants.organizationId)!;

    return (await ApiService().dioGet(
      url:
          "${EndpointConstants.baseUrl}/departamentmanager/managersnodepartament/$organizationId",
    ))
        .fold(
      (l) => left(l),
      (r) => right(
        (r as List).map((e) => Manager.fromJson(e)).toList(growable: false),
      ),
    );
  }

  Future<Either<Failure<String>, List<DepartmentSummary>>>
      getDepartmentsFromOrganization() async {
    var box = Hive.box<String>(HiveConstants.authBox);
    String organizationId = box.get(HiveConstants.organizationId)!;

    return (await ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/departamentmanager/getdepartamentsfromorganization/$organizationId",
    ))
        .fold(
      (l) => left(l),
      (r) => right(
        r.map((e) => DepartmentSummary.fromJson(e)).toList(growable: false),
      ),
    );
  }
}
