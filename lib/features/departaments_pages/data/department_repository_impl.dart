import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/features/auth/data/models/manager.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/alocation.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/dealocation.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/department.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/validation.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';
import 'package:team_finder_app/features/project_pages/data/models/project_model.dart';

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
          "${EndpointConstants.baseUrl}/employee/departamentemployees/$departamentId",
    ))
        .fold(
      (l) => left(l),
      (r) => right(
        r.map((e) => Employee.fromJson(e)).toList(growable: false),
      ),
    );
  }

  Future<Either<Failure<String>, List<Employee>>> getFreeEmployees() async {
    var box = Hive.box<String>(HiveConstants.authBox);
    String organizationId = box.get(HiveConstants.organizationId)!;
    return (await ApiService().dioGet(
      url:
          "${EndpointConstants.baseUrl}/employee/employeesnodepartament/$organizationId",
    ))
        .fold(
      (l) => left(l),
      (r) => right(
        (r as List).map((e) => Employee.fromJson(e)).toList(growable: false),
      ),
    );
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

//get statistics for departametn

  Future<Either<Failure<String>, Map<String, int>>> getStatisticsForDepartament(
    String departamentId,
    String skillId,
  ) async {
    return (await ApiService().dioGet(
      url:
          "${EndpointConstants.baseUrl}/departamentmanager/chartdiagramspecialistlevel/${departamentId}/${skillId}",
    ))
        .fold(
            (l) => left(l),
            (r) => right(
                  (r as Map).map((key, value) => MapEntry(key, value as int)),
                ));
  }

  //get projects for departament
  Future<Either<Failure<String>, List<ProjectModel>>> getProjectsForDepartament(
      String departamentId) async {
    return (await ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/project/getprojectsfromadepartamentmembers/$departamentId",
    ))
        .fold(
      (l) => left(l),
      (r) => right(
        r.map((e) => ProjectModel.fromMap(e)).toList(growable: false),
      ),
    );
  }

  //add employees to departament
  Future<Either<Failure<String>, void>> addEmployeesToDepartment({
    required String departmentId,
    required List<Employee> employees,
  }) async {
    for (var e in employees) {
      (await ApiService().dioPut(
        url: "${EndpointConstants.baseUrl}/employee/assigndepartament",
        data: {
          "employeeId": e.id,
          "departamentId": departmentId,
        },
      ))
          .fold(
        (l) => left(l),
        (r) {},
      );
    }

    return right(null);
  }

  //removeEmployeeFromDepartment
  Future<Either<Failure<String>, void>> removeEmployeeFromDepartment(
      String departamentId, String employeeId) async {
    //TODO: remove employee from department correct endpoint
    return (await ApiService().dioPut(
      url: "${EndpointConstants.baseUrl}/employee/removedepartament",
      data: {
        "employeeId": employeeId,
        "departamentId": departamentId,
      },
    ))
        .fold(
      (l) => left(l),
      (r) => right(r),
    );
  }

  //deleteSkillFromDepartament
  Future<Either<Failure<String>, void>> deleteSkillFromDepartament(
      String departamentId, String skillId) async {
    return (await ApiService().dioPut(
      url: "${EndpointConstants.baseUrl}/departament/removeskill",
      data: {
        "skillId": skillId,
        "departamentId": departamentId,
      },
    ))
        .fold(
      (l) => left(l),
      (r) => right(r),
    );
  }

//getSkillsNotInDepartament
  Future<Either<Failure<String>, List<Skill>>> getSkillsNotInDepartament(
      String departamentId) async {
    var box = Hive.box<String>(HiveConstants.authBox);
    String organizationId = box.get(HiveConstants.organizationId)!;
    return (await ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/departament/notassignedskills/$departamentId/$organizationId",
    ))
        .fold(
      (l) => left(l),
      (r) => right(
        r.map((e) => Skill.fromJson(e)).toList(growable: false),
      ),
    );
  }

  //allocation/dealocation
  Future<Either<Failure<String>, List<Alocation>>> getAlocations(
      String departamentId) async {
    return (await ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/departamentmanager/departamentallocationproposal/$departamentId",
    ))
        .fold(
      (l) => left(l),
      (r) => right(
        r.map((e) => Alocation.fromMap(e)).toList(growable: false),
      ),
    );
  }

  Future<Either<Failure<String>, List<Dealocation>>> getDealocations(
      String departamentId) async {
    return (await ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/departamentmanager/departamentdeallocationonproposal/$departamentId",
    ))
        .fold(
      (l) => left(l),
      (r) => right(
        r.map((e) => Dealocation.fromMap(e)).toList(growable: false),
      ),
    );
  }

  Future<Either<Failure<String>, List<Validation>>> fetchValidation(
      String departamentId) {
    return ApiService()
        .dioGet<List>(
          url:
              "${EndpointConstants.baseUrl}/departamentmanager/getproposalsforskills/$departamentId",
        )
        .then(
          (value) => value.fold(
            (l) => left(l),
            (r) => right(
              r.map((e) => Validation.fromMap(e)).toList(growable: false),
            ),
          ),
        );
  }

  //accept/refuze

  Future<Either<Failure<String>, void>> acceptValidation(String validationId) {
    return ApiService().dioPut(
      url:
          "${EndpointConstants.baseUrl}/departamentmanager/approveproposalsforskills/$validationId",
      data: {
        "proposalId": validationId,
      },
    ).then(
      (value) => value.fold(
        (l) => left(l),
        (r) => right(r),
      ),
    );
  }

  Future<Either<Failure<String>, void>> refuseValidation(String validationId) {
    return ApiService()
        .dioDelete(
          url:
              "${EndpointConstants.baseUrl}/departamentmanager/denyproposalsforskills/$validationId",
        )
        .then(
          (value) => value.fold(
            (l) => left(l),
            (r) => right(r),
          ),
        );
  }
}
