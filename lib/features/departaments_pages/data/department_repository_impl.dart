import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/features/auth/data/models/manager.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/department.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';

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

  Future<Either<Failure<String>, List<Employee>>> getDepartamentEmployees(
      String departamentId) async {
    return (await ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/departamentmanager/getdepartamentemployees/$departamentId",
    ))
        .fold(
      (l) => left(l),
      (r) => right(
        r.map((e) => Employee.fromJson(e)).toList(growable: false),
      ),
    );
  }

  Future<Either<Failure<String>, void>> getFreeEmployees({
    required String departamentId,
  }) async {
    return (ApiService().dioPut(
      url:
          "${EndpointConstants.baseUrl}/departamentmanager/getfreeemployees/$departamentId",
    ));
  }

  Future<Either<Failure<String>, String>> createSkill(
      {required Skill skill}) async {
    var box = Hive.box<String>(HiveConstants.authBox);
    String organizationId = box.get(HiveConstants.organizationId)!;
    String userId = box.get(HiveConstants.userId)!;

    return (await ApiService().dioPost(
      url: "${EndpointConstants.baseUrl}/departamentmanager/createskill",
      data: {
        "name": skill.name,
        "category": skill.category,
        "description": skill.description,
        "organizationId": organizationId,
        "authorId": userId,
      },
    ))
        .fold(
      (l) => left(l),
      (r) => right(r['id']),
    );
  }

  Future<Either<Failure<String>, void>> assignSkillToDepartament({
    required String skillId,
    required String departamentId,
  }) async {
    return (await ApiService().dioPost(
      url: "${EndpointConstants.baseUrl}/departament/skilltodepartament",
      data: {"skillId": skillId, "departamentId": departamentId},
    ));
  }

  //get skills for departament

  Future<Either<Failure<String>, List<Skill>>> getSkillsForDepartament(
      String departamentId) async {
    return (await ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/departament/skillsofdepartament/$departamentId",
    ))
        .fold(
      (l) => left(l),
      (r) => right(
        r.map((e) => Skill.fromJson(e)).toList(growable: false),
      ),
    );
  }
}
