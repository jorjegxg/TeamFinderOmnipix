import 'package:team_finder_app/core/exports/rest_imports.dart';

class DepartmentManagerRepoImpl {
  Future<Either<Failure<String>, Map<String, dynamic>>> createSkill({
    required String category,
    required String name,
    required String description,
    required String authorId,
    required String organizationId,
  }) async {
    return ApiService().dioPost(
      url: EndpointConstants.baseUrl + EndpointConstants.createSkill,
      data: {
        "category": category,
        "name": name,
        "description": description,
        "authorId": authorId,
        "organizationId": organizationId,
      },
    );
  }

  Future<Either<Failure<String>, Map<String, dynamic>>> editSkill({
    required String skillId,
    required String managerId,
    required String name,
    required String category,
    required String description,
  }) async {
    return ApiService().dioPut(
      url: EndpointConstants.baseUrl + EndpointConstants.editSkill,
      data: {
        "skillId": skillId,
        "managerId": managerId,
        "name": name,
        "category": category,
        "description": description,
      },
    );
  }

  Future<Either<Failure<String>, Map<String, dynamic>>> getSkillsOfOrganization(
      String organizationId) async {
    return ApiService().dioGet(
      url: EndpointConstants.baseUrl +
          EndpointConstants.getSkillsOfOrganization(organizationId),
    );
  }

  Future<Either<Failure<String>, Map<String, dynamic>>> managersNoDepartament(
      String id) async {
    return ApiService().dioGet(
      url: EndpointConstants.baseUrl +
          EndpointConstants.managersNoDepartament(id),
    );
  }

  Future<Either<Failure<String>, Map<String, dynamic>>> ownedSkills(
      String authorId) async {
    return ApiService().dioGet(
      url: EndpointConstants.baseUrl + EndpointConstants.ownedSkills(authorId),
    );
  }

  //vt1
}
