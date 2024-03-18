import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';
import 'package:team_finder_app/features/settings/data/models/role_model.dart';

@injectable
class SettingsRepoImpl {
  Future<String> getOrganizationId() async {
    final box = Hive.box<String>(HiveConstants.authBox);
    return box.get(HiveConstants.organizationId)!;
  }

  //get team roles
  Future<Either<Failure, List<RoleModel>>> getTeamRoles() async {
    return ApiService()
        .dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/organization/teamroles/${await getOrganizationId()}",
    )
        .then((response) {
      return response.fold(
        (l) => left(l),
        (r) {
          final List<RoleModel> teamRoles = [];
          for (var role in r) {
            teamRoles.add(RoleModel.fromJson(role));
          }
          return right(teamRoles);
        },
      );
    });
  }

  //add team role
  Future<Either<Failure, void>> addTeamRole(RoleModel role) async {
    return ApiService().dioPost(
      url: "${EndpointConstants.baseUrl}/admin/customrole",
      data: {
        "name": role.name,
        "organizationId": await getOrganizationId(),
      },
    ).then((response) {
      return response.fold(
        (l) => left(l),
        (r) => right(null),
      );
    });
  }

  //remove team role
  Future<Either<Failure, void>> deleteTeamRole(RoleModel role) async {
    return ApiService()
        .dioDelete(
      url: "${EndpointConstants.baseUrl}/teamroles/$role",
    )
        //TODO: Implement deleteTeamRole
        .then((response) {
      return response.fold(
        (l) => left(l),
        (r) => right(null),
      );
    });
  }

  //get skills
  Future<Either<Failure, List<Skill>>> getFreeSkills() async {
    //hive
    final box = Hive.box<String>(HiveConstants.authBox);
    final employeeId = box.get(HiveConstants.userId);
    final organizationId = box.get(HiveConstants.organizationId);

    return ApiService()
        .dioGet<List>(
      url:
          "${EndpointConstants.baseUrl}/employee/notassignedskills/$employeeId/$organizationId",
    )
        .then((response) {
      return response.fold(
        (l) => left(l),
        (r) {
          final List<Skill> skills = [];
          for (var skill in r) {
            skills.add(Skill.fromJson(skill));
          }
          return right(skills);
        },
      );
    });
  }

  //add skill to employee
  Future<Either<Failure, void>> addSkillToEmployee(
    String skillId,
    int level,
    int experience,
    List<Map<String, String>> endorsments,
    List<String> projectsIds,
  ) async {
    final box = Hive.box<String>(HiveConstants.authBox);
    final employeeId = box.get(HiveConstants.userId);
    return ApiService().dioPost(
      url: "${EndpointConstants.baseUrl}/employee/assignskill",
      data: {
        "employeeId": employeeId,
        "skillId": skillId,
        "level": level,
        "experience": experience,
        "endorsements": endorsments,
        "projectId": projectsIds,
      },
    ).then((response) {
      return response.fold(
        (l) => left(l),
        (r) => right(null),
      );
    });
  }

  //get skills for employee
  Future<Either<Failure<String>, List<Skill>>> getSkillsForEmployee() async {
    final box = Hive.box<String>(HiveConstants.authBox);
    final employeeId = box.get(HiveConstants.userId);

    return (await ApiService().dioGet<List>(
      url: "${EndpointConstants.baseUrl}/employee/getskills/$employeeId",
    ))
        .fold(
      (l) => left(l),
      (r) => right(
        r.map((e) => Skill.fromJson(e)).toList(growable: false),
      ),
    );
  }

  //change password
  Future<Either<Failure, void>> changePassword(
      String newPassword, String email) async {
    return ApiService()
        .dioPut(
      url:
          "${EndpointConstants.baseUrl}/admin/updatepassword/$email/$newPassword",
    )
        .then((response) {
      return response.fold(
        (l) => left(l),
        (r) => right(null),
      );
    });
  }

  //get current employee
  Future<Either<Failure, Employee>> getCurrentEmployee() async {
    final box = Hive.box<String>(HiveConstants.authBox);
    final employeeId = box.get(HiveConstants.userId);
    return ApiService()
        .dioGet(
      url: "${EndpointConstants.baseUrl}/employee/info/$employeeId",
    )
        .then((response) {
      return response.fold(
        (l) => left(l),
        (r) => right(Employee.fromJson(r)),
      );
    });
  }

  //update name and email
  Future<Either<Failure, void>> updateNameAndEmail(
      String name, String email) async {
    final box = Hive.box<String>(HiveConstants.authBox);
    final employeeId = box.get(HiveConstants.userId);
    return ApiService()
        .dioPut(
      url:
          "${EndpointConstants.baseUrl}/employee/editemailandname/$employeeId/$email/$name",
    )
        .then((response) {
      return response.fold(
        (l) => left(l),
        (r) => right(null),
      );
    });
  }

  //delete skill
  Future<Either<Failure, void>> deleteSkill(String skillId) async {
    return ApiService()
        .dioDelete(
      url: "${EndpointConstants.baseUrl}/employee/deleteskill/$skillId",
    )
        .then((response) {
      return response.fold(
        (l) => left(l),
        (r) => right(null),
      );
    });
  }
}
