import "package:team_finder_app/core/exports/rest_imports.dart";

class EmployeeRepoImpl {
  Future<Either<Failure<String>, String>> assignDepartment({
    required String employeeId,
    required String departamentId,
  }) async {
    return ApiService().dioPut<String>(
        url: EndpointConstants.baseUrl + EndpointConstants.assignDepartment,
        data: {
          "employeeId": employeeId,
          "departamentId": departamentId,
        });
  }

  // Future<Either<Failure<String>, String>> assignSkill({
  //   required String employeeId,
  //   required String skillId,
  //   required int level,
  //   required int experience,
  //   required List<Endorsement> endorsements,
  // }) async {
  //   return ApiService().dioPost<String>(
  //       url: EndpointConstants.baseUrl + EndpointConstants.assignSkill,
  //       data: {
  //         "employeeId": employeeId,
  //         "skillId": skillId,
  //         "level": level,
  //         "experience": experience,
  //         "endorsements": endorsements,
  //       });
  // }

  Future<Either<Failure<String>, String>> createUser({
    required String name,
    required String email,
    required String password,
    required String organizationId,
  }) async {
    return ApiService().dioPost<String>(
        url: EndpointConstants.baseUrl + EndpointConstants.createUser,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "organizationId": organizationId,
        });
  }

  Future<Either<Failure<String>, String>> getSkills(String userId) async {
    return ApiService().dioGet<String>(
      url: EndpointConstants.baseUrl + EndpointConstants.getSkills(userId),
    );
  }
}
