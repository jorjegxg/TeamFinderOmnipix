import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/core/util/logger.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';
import 'package:team_finder_app/features/project_pages/data/models/project_model.dart';
import 'package:team_finder_app/features/project_pages/data/models/team_role.dart';
import 'package:team_finder_app/features/project_pages/data/models/technology_stack.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';
import 'package:team_finder_app/features/project_pages/domain/repositories/project_repo.dart';

@LazySingleton(as: ProjectRepo)
class ProjectRepoImpl extends ProjectRepo {
  @override
  Future<Either<Failure<String>, List<ProjectModel>>>
      getCurrentUserActiveProjects() async {
    var box = Hive.box<String>(HiveConstants.authBox);
    String employeeId = box.get(HiveConstants.userId)!;
    return (await ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/project/projectdetailactive/$employeeId",
      codeMessage: {
        404: "No active projects found",
      },
    ))
        .fold(
      (l) {
        Logger.info("ERROR MESSAGE:", l.message);
        return Left(l);
      },
      (r) {
        final List<ProjectModel> projects = [];
        for (var project in r) {
          projects.add(ProjectModel.fromMap(project));
        }
        return Right(projects);
      },
    );
  }

  @override
  Future<Either<Failure<String>, List<ProjectModel>>>
      getCurrentUserInActiveProjects() async {
    var box = Hive.box<String>(HiveConstants.authBox);
    String employeeId = box.get(HiveConstants.userId)!;
    return (await ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/project/projectdetailinactive/$employeeId",
      codeMessage: {
        404: "No inactive projects found",
      },
    ))
        .fold(
      (l) => Left(l),
      (r) {
        final List<ProjectModel> projects = [];
        for (var project in r) {
          projects.add(ProjectModel.fromMap(project));
        }
        return Right(projects);
      },
    );
  }

  @override
  Future<Either<Failure<String>, void>> createProject(
      {required ProjectModel newProject}) async {
    var box = Hive.box<String>(HiveConstants.authBox);
    String organizationId = box.get(HiveConstants.organizationId)!;
    String userId = box.get(HiveConstants.userId)!;
// {
//   "name": "string",
//   "period": "string",
//   "startDate": "2024-03-16T13:47:33.247Z",
//   "deadlineDate": "2024-03-16T13:47:33.247Z",
//   "description": "string",
//   "technologyStack": [
//     "string"
//   ],
//   "teamRoles": {},
//   "status": "string",
//   "organizationId": "string",
//   "employeeId": "string"
// }
    //make from map<TeamRole,int> to map<teamrole.id,int>
    Map<String, int> teamRoles = {};
    newProject.teamRoles.forEach((key, value) {
      teamRoles.putIfAbsent(key.id, () => value);
    });
    return (await ApiService().dioPost(
      url: "${EndpointConstants.baseUrl}/project",
      data: {
        "name": newProject.name,
        "period": newProject.period.toStringValue(),
        "startDate": newProject.startDate.toString(),
        "deadlineDate": newProject.deadlineDate.toString(),
        "description": newProject.description,
        "technologyStack": newProject.technologyStack.map((e) => e.id).toList(),
        "teamRoles": teamRoles,
        "status": newProject.status,
        "organizationId": organizationId,
        "employeeId": userId,
      },
    ))
        .fold(
      (l) {
        return Left(l);
      },
      (r) {
        return const Right(null);
      },
    );
  }

  @override
  Future<Either<Failure<String>, String>> createTechnology(
      {required TechnologyStack newTechnology}) async {
//      {
//   "name": "string",
//   "organizationId": "string"
// }
    var box = Hive.box<String>(HiveConstants.authBox);
    String organizationId = box.get(HiveConstants.organizationId)!;
    return (await ApiService().dioPost(
      url: "${EndpointConstants.baseUrl}/projectmanager/technologystack",
      data: {
        "name": newTechnology.name,
        "organizationId": organizationId,
      },
    ))
        .fold(
      (l) => Left(l),
      (r) => Right(r['id']),
    );
  }

  @override
  Future<Either<Failure<String>, List<TeamRole>>> getTeamRoles() {
    var box = Hive.box<String>(HiveConstants.authBox);
    String organizationId = box.get(HiveConstants.organizationId)!;
    return (ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/organization/teamroles/$organizationId",
      codeMessage: {
        404: "No team roles found",
      },
    )).then((value) {
      return value.fold(
        (l) => Left(l),
        (r) {
          final List<TeamRole> teamRoles = [];
          for (var role in r) {
            teamRoles.add(TeamRole.fromJson(role));
          }
          return Right(teamRoles);
        },
      );
    });
  }

  @override
  Future<Either<Failure<String>, List<TechnologyStack>>> getTechnologyStack() {
    ///projectmanager/gettechnologystacks/{organizationId}
    var box = Hive.box<String>(HiveConstants.authBox);
    String organizationId = box.get(HiveConstants.organizationId)!;
    return (ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/projectmanager/gettechnologystacks/$organizationId",
      codeMessage: {
        404: "No technology stacks found",
      },
    )).then((value) {
      return value.fold(
        (l) => Left(l),
        (r) {
          final List<TechnologyStack> technologyStack = [];
          for (var tech in r) {
            technologyStack.add(TechnologyStack.fromMap(tech));
          }
          return Right(technologyStack);
        },
      );
    });
  }

  @override
  Future<Either<Failure<String>, void>> editProject(
      {required ProjectEntity editedProject}) async {
    Map<String, int> teamRoles = {};
    editedProject.teamRoles.forEach((key, value) {
      teamRoles.putIfAbsent(key.id, () => value);
    });
    return (await ApiService().dioPut(
      url: "${EndpointConstants.baseUrl}/project/updateproject",
      data: {
        "projectId": editedProject.id,
        "name": editedProject.name,
        "period": editedProject.period.toStringValue(),
        "startDate": editedProject.startDate.toString(),
        "deadlineDate": editedProject.deadlineDate.toString(),
        "description": editedProject.description,
        "technologyStack":
            editedProject.technologyStack.map((e) => e.id).toList(),
        "teamRoles": teamRoles,
        "status": editedProject.status,
      },
    ))
        .fold(
      (l) {
        return Left(l);
      },
      (r) {
        return const Right(null);
      },
    );
  }

  @override
  Future<Either<Failure<String>, void>> deleteProject(
      {required String projectId}) {
    return ApiService()
        .dioDelete(
      url: "${EndpointConstants.baseUrl}/project/deleteproject/$projectId",
    )
        .then((value) {
      return value.fold(
        (l) => Left(l),
        (r) => const Right(null),
      );
    });
  }

  @override
  Future<Either<Failure<String>, List<Employee>>> getActiveMembers(
      String projectId) {
    return ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/project/activemembersproject/$projectId",
      codeMessage: {
        404: "No active members found",
      },
    ).then((value) {
      return value.fold(
        (l) => Left(l),
        (r) => Right(r.map((e) => Employee.fromJson(e)).toList()),
      );
    });
  }

  @override
  Future<Either<Failure<String>, List<Employee>>> getInActiveMembers(
      String projectId) {
    return ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/project/inactivemembersproject/$projectId",
      codeMessage: {
        404: "No inactive members found",
      },
    ).then((value) {
      return value.fold(
        (l) => Left(l),
        (r) => Right(r.map((e) => Employee.fromJson(e)).toList()),
      );
    });
  }

  @override
  Future<Either<Failure<String>, List<Employee>>> getFutureMembers(
      String projectId) {
    return ApiService().dioGet<List>(
      url: "${EndpointConstants.baseUrl}/project/getproposedmembers/$projectId",
      codeMessage: {
        404: "no members found",
      },
    ).then((value) {
      return value.fold(
        (l) => Left(l),
        (r) => Right(r.map((e) => Employee.fromJson(e['employeeId'])).toList()),
      );
    });
  }

  @override
  Future<Either<Failure<String>, List<Employee>>> fetchFullyAvalibleMembers(
    String projectId,
  ) {
    //hive
    var box = Hive.box<String>(HiveConstants.authBox);
    String organizationId = box.get(HiveConstants.organizationId)!;

    return ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/project/freeemployees/$organizationId/$projectId",
      codeMessage: {
        404: "No members found",
      },
    ).then((value) {
      return value.fold(
        (l) => Left(l),
        (r) => Right(r.map((e) => Employee.fromJson(e)).toList()),
      );
    });
  }

  //fetch unavailable members
  @override
  Future<Either<Failure<String>, List<Employee>>> fetchUnavailableMembers(
      String projectId) {
    //hive
    var box = Hive.box<String>(HiveConstants.authBox);
    String organizationId = box.get(HiveConstants.organizationId)!;

    return ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/project/unavailableavailableemployees/$organizationId/$projectId",
      codeMessage: {
        404: "No members found",
      },
    ).then((value) {
      return value.fold(
        (l) => Left(l),
        (r) => Right(r.map((e) => Employee.fromJson(e)).toList()),
      );
    });
  }

  //fetch partially available members
  @override
  Future<Either<Failure<String>, List<Employee>>> fetchPartialyAvabileMembers(
      String projectId) {
    var box = Hive.box<String>(HiveConstants.authBox);
    String organizationId = box.get(HiveConstants.organizationId)!;

    return ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/project/getpartialyavailableemployees/$organizationId/$projectId",
      codeMessage: {
        404: "No members found",
      },
    ).then((value) {
      return value.fold(
        (l) => Left(l),
        (r) => Right(r.map((e) => Employee.fromJson(e)).toList()),
      );
    });
  }

  @override
  Future<Either<Failure<String>, List<Skill>>> getSkills() {
    var box = Hive.box<String>(HiveConstants.authBox);
    String organizationId = box.get(HiveConstants.organizationId)!;

    return ApiService().dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/departamentmanager/getskills/$organizationId",
      codeMessage: {
        404: "No skills found",
      },
    ).then((value) {
      return value.fold(
        (l) => Left(l),
        (r) => Right(r.map((e) => Skill.fromJson(e)).toList()),
      );
    });
  }

  @override
  Future<Either<Failure<String>, void>> postSkillReq(
      {required String projectId, required Map<String, int> skill}) {
    return ApiService().dioPost(
      url: "${EndpointConstants.baseUrl}/employee/postskillinproject",
      data: {
        "projectId": projectId,
        "skillId": skill.keys.first,
        "minimumLevel": skill.values.first,
      },
    ).then((value) {
      return value.fold(
        (l) => Left(l),
        (r) => const Right(null),
      );
    });
  }

  @override
  Future<Either<Failure<String>, List<Employee>>> fetchMembersWithChatGPT(
      {required String message}) {
    var box = Hive.box<String>(HiveConstants.authBox);
    String organizationId = box.get(HiveConstants.organizationId)!;
    return ApiService().dioPost(
      url: "${EndpointConstants.baseUrl}/openai/",
      data: {
        "content": message,
        "organizationId": organizationId,
      },
    ).then((value) {
      return value.fold((l) => Left(l), (r) {
        Logger.info("VALUE:", r.toString());
        if (r['message']['message'] is String) {
          return Left(EasyFailure(message: "No employees found"));
        }
        return Right(
            r['message']['message'].map((e) => Employee.fromJson(e)).toList());
      });
    });
  }

  @override
  Future<Either<Failure<String>, void>> sendProposal({
    required ProjectEntity project,
    required String proposal,
    required int workHours,
    required List<TeamRole> teamRoles,
    required String employeeId,
  }) async {
    return await ApiService().dioPost(
      url: "${EndpointConstants.baseUrl}/project/assignproposal",
      data: {
        "projectId": project.id,
        "employeeId": employeeId,
        "numberOfHours": workHours,
        "teamRolesId": teamRoles.map((e) => e.id).toList(),
        "comment": proposal,
      },
    ).then((value) {
      return value.fold(
        (l) => Left(l),
        (r) => const Right(null),
      );
    });
  }

  @override
  Future<Either<Failure<String>, void>> sendDealocationProposal(
      {required String projectId,
      required String proposal,
      required String employeeId}) {
    return ApiService().dioPost(
      url:
          "${EndpointConstants.baseUrl}/departament/createadealocationproposal",
      data: {
        "projectId": projectId,
        "employeeId": employeeId,
        "comment": proposal,
      },
    ).then((value) {
      return value.fold(
        (l) => Left(l),
        (r) => const Right(null),
      );
    });
  }
}
