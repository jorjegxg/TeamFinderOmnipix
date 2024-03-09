import 'package:dartz/dartz.dart';
import 'package:team_finder_app/core/api_service.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/core/util/constants.dart';

class EmployeeRepoImpl {
  /** ///user endpoints///
  static const String assignDepartment = '/employee/assigndepartament';
  {
  "employeeId": "string",
  "departamentId": "string"
}
  static const String assignSkill = '/employee/assignskill';
  {
  "employeeId": "string",
  "skillId": "string",
  "level": 0,
  "experience": 0,
  "endorsements": [
    {
      "title": "string",
      "description": "string"
    }
  ]
}
  static const String createUser = '/employee/create';
  {
  "name": "string",
  "email": "string",
  "password": "string",
  "organizationId": "string"
}
  static String getSkills(String userId) => '/employee/getskills/$userId';
  -

 */

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
