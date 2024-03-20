import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/features/auth/data/models/manager.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/alocation.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/dealocation.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/department_summary.dart';
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
    var box = Hive.box<String>(HiveConstants.authBox);
    String employeeId = box.get(HiveConstants.userId)!;

    if (managerId == employeeId) {
      await FirebaseMessaging.instance.subscribeToTopic(departmentId);
    }

    //trebuie sa facem un subscribe la topicul departamentului
    //atunci cand se schimba managerul -- sa se dezaboneze de la vechiul topic
    //la login sa se aboneze la topicul departamentului -- daca e manager

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
      codeMessage: {404: "No managers found"},
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
    String userId = box.get(HiveConstants.userId)!;

    return (await ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/departamentmanager/getdepartamentsfromorganization/$organizationId",
      codeMessage: {404: "No departments found"},
    ))
        .fold(
      (l) => left(l),
      (r) {
        List<DepartmentSummary> myDepartments;
        List<DepartmentSummary> notMyDepartments;

        myDepartments = r
            .map((e) => DepartmentSummary.fromJson(e))
            .where((element) => element.employeeId == userId)
            .toList(growable: false);

        for (var d in myDepartments) {
          d.isCurrentUserManager = true;
        }

        notMyDepartments = r
            .map((e) => DepartmentSummary.fromJson(e))
            .where((element) => element.employeeId != userId)
            .toList(growable: false);

        return right(myDepartments + notMyDepartments);
      },
    );
  }

  Future<Either<Failure<String>, List<Employee>>> getDepartamentEmployees(
      String departamentId) async {
    return (await ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/employee/departamentemployees/$departamentId",
      codeMessage: {
        404: "No employees found",
      },
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
      codeMessage: {
        404: "No employees found",
      },
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
      codeMessage: {
        404: "No skills found",
      },
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
          "${EndpointConstants.baseUrl}/departamentmanager/chartdiagramspecialistlevel/$departamentId/$skillId",
      codeMessage: {
        404: "No statistics found",
      },
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
      codeMessage: {
        404: "No projects found",
      },
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
        codeMessage: {
          404: "No employees found",
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
      String employeeId) async {
    return (await ApiService().dioPut(
      url:
          "${EndpointConstants.baseUrl}/departamentmanager/kickemployeefromdepartament/$employeeId",
    ))
        .fold(
      (l) => left(l),
      (r) => right(r),
    );
  }

  //deleteSkillFromDepartament
  Future<Either<Failure<String>, void>> deleteSkillFromDepartament(
      String departamentId, String skillId) async {
    return (await ApiService().dioDelete(
      url:
          "${EndpointConstants.baseUrl}/departamentmanager/deleteskillfromdepartament/$skillId/$departamentId",
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
      codeMessage: {
        404: "No skills found",
      },
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
      codeMessage: {
        404: "No alocations found",
      },
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
      codeMessage: {
        404: "No dealocations found",
      },
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
    return ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/departamentmanager/getproposalsforskills/$departamentId",
      codeMessage: {
        404: "No validation found",
      },
    ).then(
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

  Future<Either<Failure<String>, void>> assignSkillDirectly(Employee employee,
      String departamentId, String skillId, int experience, int level) {
    return ApiService().dioPut(
      url:
          "${EndpointConstants.baseUrl}/departamentmanager/assignskilldirectly",
      data: {
        "departamentId": departamentId,
        "employeeId": employee.id,
        "experience": experience,
        "level": level,
        "skillId": skillId
      },
    ).then(
      (value) => value.fold(
        (l) => left(l),
        (r) => right(r),
      ),
    );
  }

  Future<Either<Failure<String>, List<String>>> getCategories() {
    var box = Hive.box<String>(HiveConstants.authBox);
    String organizationId = box.get(HiveConstants.organizationId)!;
    return ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/projectmanager/getskillcategories/$organizationId",
      codeMessage: {
        404: "No categories found",
      },
    ).then(
      (value) => value.fold(
        (l) => left(l),
        (r) => right(
          r.map((e) => e as String).toList(growable: false),
        ),
      ),
    );
  }

  Future<Either<Failure<String>, void>> deleteDepartment(
      String departamentId) async {
    return ApiService()
        .dioDelete(
          url:
              "${EndpointConstants.baseUrl}/departament/deletedepartament/$departamentId",
        )
        .then(
          (value) => value.fold(
            (l) => left(l),
            (r) => right(null),
          ),
        );
  }

  Future<Either<Failure<String>, void>> refuseAlocation(String id) {
    return ApiService()
        .dioDelete(
          url:
              "${EndpointConstants.baseUrl}/departament/declineprojectproposal/$id",
        )
        .then(
          (value) => value.fold(
            (l) => left(l),
            (r) => right(r),
          ),
        );
  }

  Future<Either<Failure<String>, void>> acceptAlocation(String id) {
    return ApiService()
        .dioPost(
          url:
              "${EndpointConstants.baseUrl}/departament/acceptprojectproposal/$id",
        )
        .then(
          (value) => value.fold(
            (l) => left(l),
            (r) => right(r),
          ),
        );
  }

  Future<Either<Failure<String>, void>> acceptDealocation(String id) {
    return ApiService()
        .dioPut(
          url:
              "${EndpointConstants.baseUrl}/departament/acceptdealocatioproposal/$id",
        )
        .then(
          (value) => value.fold(
            (l) => left(l),
            (r) => right(r),
          ),
        );
  }

  Future<Either<Failure<String>, void>> refuseDealocation(String id) {
    return ApiService()
        .dioDelete(
          url:
              "${EndpointConstants.baseUrl}/departament/declinedealocationproposal/$id",
        )
        .then(
          (value) => value.fold(
            (l) => left(l),
            (r) => right(r),
          ),
        );
  }
}
