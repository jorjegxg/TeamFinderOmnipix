import "package:team_finder_app/core/exports/rest_imports.dart";
import "package:team_finder_app/data/models/endorsement.dart";

class EmployeeRepoImpl {
  Future<Either<Failure<String>, Map<String, dynamic>>> assignDepartment({
    required String employeeId,
    required String departamentId,
  }) async {
    return ApiService().dioPut<Map<String, dynamic>>(
        url: EndpointConstants.baseUrl + EndpointConstants.assignDepartment,
        data: {
          "employeeId": employeeId,
          "departamentId": departamentId,
        });
  }

  Future<Either<Failure<String>, String>> assignSkill({
    required String employeeId,
    required String skillId,
    required int level,
    required int experience,
    required List<Endorsement> endorsements,
  }) async {
    return ApiService().dioPost<String>(
        url: EndpointConstants.baseUrl + EndpointConstants.assignSkill,
        data: {
          "employeeId": employeeId,
          "skillId": skillId,
          "level": level,
          "experience": experience,
          "endorsements": endorsements.map((e) => e.toMap()).toList(),
        });
  }

  Future<Either<Failure<String>, Map<String, dynamic>>> createUser({
    required String name,
    required String email,
    required String password,
    required String organizationId,
  }) async {
    return ApiService().dioPost<Map<String, dynamic>>(
        url: EndpointConstants.baseUrl + EndpointConstants.createUser,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "organizationId": organizationId,
        });
  }

  Future<Either<Failure<String>, Map<String, dynamic>>> getSkills(
      String userId) async {
    return ApiService().dioGet<Map<String, dynamic>>(
      url: EndpointConstants.baseUrl + EndpointConstants.getSkills(userId),
    );
  }
}


