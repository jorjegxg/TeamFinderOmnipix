import "package:team_finder_app/core/exports/rest_imports.dart";

class DepartmentRepoImpl extends DepartmentRepo {
  @override
  Future<Either<Failure<String>, Map<String, dynamic>>> createDepartament({
    required String name,
    required String organizationId,
  }) async {
    return ApiService().dioPost<Map<String, dynamic>>(
        url: EndpointConstants.baseUrl + EndpointConstants.createDepartament,
        data: {
          "name": name,
          "organizationId": organizationId,
        });
  }

  @override
  Future<Either<Failure<String>, Map<String, dynamic>>> createDepartamentAdditional({
    required String name,
    required String organizationId,
  }) async {
    return ApiService().dioPost<Map<String, dynamic>>(
        url: EndpointConstants.baseUrl +
            EndpointConstants.createDepartamentAdditional,
        data: {
          "name": name,
          "organizationId": organizationId,
        });
  }

  @override
  Future<Either<Failure<String>, Map<String, dynamic>>> createDepartamentManager({
    required String employeeId,
    required String organizationId,
  }) async {
    return ApiService().dioPost<Map<String, dynamic>>(
        url: EndpointConstants.baseUrl +
            EndpointConstants.createDepartamentManager,
        data: {
          "employeeId": employeeId,
          "organizationId": organizationId,
        });
  }

  @override
  Future<Either<Failure<String>, Map<String, dynamic>>>
      createDepartamentDirectlyWithManagerAdditional({
    required String name,
    required String organizationId,
    required String employeeId,
  }) async {
    return ApiService().dioPost<Map<String, dynamic>>(
        url: EndpointConstants.baseUrl +
            EndpointConstants.createDepartamentDirectlyWithManagerAdditional,
        data: {
          "name": name,
          "organizationId": organizationId,
          "employeeId": employeeId,
        });
  }

  @override
  Future<Either<Failure<String>, Map<String, dynamic>>> deleteDepartament(
      String departamentId) async {
    return ApiService().dioDelete<Map<String, dynamic>>(
        url: EndpointConstants.baseUrl +
            EndpointConstants.deleteDepartament(departamentId));
  }

  @override
  Future<Either<Failure<String>, Map<String, dynamic>>> firstPromoteDepartamentManager({
    required String employeeId,
    required String departamentId,
  }) async {
    return ApiService().dioPost<Map<String, dynamic>>(
        url: EndpointConstants.baseUrl +
            EndpointConstants.firstPromoteDepartamentManager,
        data: {
          "employeeId": employeeId,
          "departamentId": departamentId,
        });
  }

  @override
  Future<Either<Failure<String>, Map<String, dynamic>>> promoteDepartamentManagerAdditional({
    required String employeeId,
    required String departamentId,
  }) async {
    return ApiService().dioPost<Map<String, dynamic>>(
        url: EndpointConstants.baseUrl +
            EndpointConstants.promoteDepartamentManagerAdditional,
        data: {
          "employeeId": employeeId,
          "departamentId": departamentId,
        });
  }

  @override
  Future<Either<Failure<String>, Map<String, dynamic>>> skillsOfDepartament(
      String departamentId) async {
    return ApiService().dioGet<Map<String, dynamic>>(
        url: EndpointConstants.baseUrl +
            EndpointConstants.skillsOfDepartament(departamentId));
  }

  @override
  Future<Either<Failure<String>, Map<String, dynamic>>> skillToDepartament({
    required String skillId,
    required String departamentId,
  }) async {
    return ApiService().dioPost<Map<String, dynamic>>(
        url: EndpointConstants.baseUrl + EndpointConstants.skillToDepartament,
        data: {
          "skillId": skillId,
          "departamentId": departamentId,
        });
  }

  @override
  Future<Either<Failure<String>, Map<String, dynamic>>> updateManager({
    required String departamentId,
    required String employeeId,
  }) async {
    return ApiService().dioPost<Map<String, dynamic>>(
        url: EndpointConstants.baseUrl + EndpointConstants.updateManager,
        data: {
          "departamentId": departamentId,
          "employeeId": employeeId,
        });
  }

  @override
  Future<Either<Failure<String>, Map<String, dynamic>>> updateNameOfDepartament({
    required String departamentId,
    required String name,
  }) async {
    return ApiService().dioPost<Map<String, dynamic>>(
        url: EndpointConstants.baseUrl +
            EndpointConstants.updateNameOfDepartament,
        data: {
          "departamentId": departamentId,
          "name": name,
        });
  }
}

//creeaza DepartmentRepo:

abstract class DepartmentRepo {
  Future<Either<Failure<String>, Map<String, dynamic>>> createDepartament({
    required String name,
    required String organizationId,
  });

  Future<Either<Failure<String>, Map<String, dynamic>>> createDepartamentAdditional({
    required String name,
    required String organizationId,
  });

  Future<Either<Failure<String>, Map<String, dynamic>>> createDepartamentManager({
    required String employeeId,
    required String organizationId,
  });

  Future<Either<Failure<String>, Map<String, dynamic>>>
      createDepartamentDirectlyWithManagerAdditional({
    required String name,
    required String organizationId,
    required String employeeId,
  });

  Future<Either<Failure<String>, Map<String, dynamic>>> deleteDepartament(
      String departamentId);

  Future<Either<Failure<String>, Map<String, dynamic>>> firstPromoteDepartamentManager({
    required String employeeId,
    required String departamentId,
  });

  Future<Either<Failure<String>, Map<String, dynamic>>> promoteDepartamentManagerAdditional({
    required String employeeId,
    required String departamentId,
  });

  Future<Either<Failure<String>, Map<String, dynamic>>> skillsOfDepartament(
      String departamentId);

  Future<Either<Failure<String>, Map<String, dynamic>>> skillToDepartament({
    required String skillId,
    required String departamentId,
  });

  Future<Either<Failure<String>, Map<String, dynamic>>> updateManager({
    required String departamentId,
    required String employeeId,
  });

  Future<Either<Failure<String>, Map<String, dynamic>>> updateNameOfDepartament({
    required String departamentId,
    required String name,
  });
}
