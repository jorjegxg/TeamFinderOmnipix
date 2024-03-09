import "package:team_finder_app/core/exports/rest_imports.dart";

class DepartamentRepoImpl {
  Future<Either<Failure<String>, String>> createDepartament({
    required String name,
    required String organizationId,
  }) async {
    return ApiService().dioPost<String>(
        url: EndpointConstants.baseUrl + EndpointConstants.createDepartament,
        data: {
          "name": name,
          "organizationId": organizationId,
        });
  }

  Future<Either<Failure<String>, String>> createDepartamentAdditional({
    required String name,
    required String organizationId,
  }) async {
    return ApiService().dioPost<String>(
        url: EndpointConstants.baseUrl +
            EndpointConstants.createDepartamentAdditional,
        data: {
          "name": name,
          "organizationId": organizationId,
        });
  }

  Future<Either<Failure<String>, String>> createDepartamentManager({
    required String employeeId,
    required String organizationId,
  }) async {
    return ApiService().dioPost<String>(
        url: EndpointConstants.baseUrl +
            EndpointConstants.createDepartamentManager,
        data: {
          "employeeId": employeeId,
          "organizationId": organizationId,
        });
  }

  Future<Either<Failure<String>, String>>
      createDepartamentDirectlyWithManagerAdditional({
    required String name,
    required String organizationId,
    required String employeeId,
  }) async {
    return ApiService().dioPost<String>(
        url: EndpointConstants.baseUrl +
            EndpointConstants.createDepartamentDirectlyWithManagerAdditional,
        data: {
          "name": name,
          "organizationId": organizationId,
          "employeeId": employeeId,
        });
  }

  Future<Either<Failure<String>, String>> deleteDepartament(
      String departamentId) async {
    return ApiService().dioDelete<String>(
        url: EndpointConstants.baseUrl +
            EndpointConstants.deleteDepartament(departamentId));
  }

  Future<Either<Failure<String>, String>> firstPromoteDepartamentManager({
    required String employeeId,
    required String departamentId,
  }) async {
    return ApiService().dioPost<String>(
        url: EndpointConstants.baseUrl +
            EndpointConstants.firstPromoteDepartamentManager,
        data: {
          "employeeId": employeeId,
          "departamentId": departamentId,
        });
  }

  Future<Either<Failure<String>, String>> promoteDepartamentManagerAdditional({
    required String employeeId,
    required String departamentId,
  }) async {
    return ApiService().dioPost<String>(
        url: EndpointConstants.baseUrl +
            EndpointConstants.promoteDepartamentManagerAdditional,
        data: {
          "employeeId": employeeId,
          "departamentId": departamentId,
        });
  }

  Future<Either<Failure<String>, String>> skillsOfDepartament(
      String departamentId) async {
    return ApiService().dioGet<String>(
        url: EndpointConstants.baseUrl +
            EndpointConstants.skillsOfDepartament(departamentId));
  }

  Future<Either<Failure<String>, String>> skillToDepartament({
    required String skillId,
    required String departamentId,
  }) async {
    return ApiService().dioPost<String>(
        url: EndpointConstants.baseUrl + EndpointConstants.skillToDepartament,
        data: {
          "skillId": skillId,
          "departamentId": departamentId,
        });
  }

  Future<Either<Failure<String>, String>> updateManager({
    required String departamentId,
    required String employeeId,
  }) async {
    return ApiService().dioPost<String>(
        url: EndpointConstants.baseUrl + EndpointConstants.updateManager,
        data: {
          "departamentId": departamentId,
          "employeeId": employeeId,
        });
  }

  Future<Either<Failure<String>, String>> updateNameOfDepartament({
    required String departamentId,
    required String name,
  }) async {
    return ApiService().dioPost<String>(
        url: EndpointConstants.baseUrl +
            EndpointConstants.updateNameOfDepartament,
        data: {
          "departamentId": departamentId,
          "name": name,
        });
  }
}
