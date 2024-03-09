import "package:team_finder_app/core/exports/rest_imports.dart";

class AdminRepoImpl {
  Future<Either<Failure<String>, Map<String, dynamic>>>
      createOrganizationAdminAccount({
    required String name,
    required String email,
    required String password,
    required String organizationName,
    required String address,
  }) async {
    return ApiService().dioPost<Map<String, dynamic>>(
        url: EndpointConstants.baseUrl + EndpointConstants.createAdmin,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "organizationName": organizationName,
          "adress": address,
          //TODO (George Luta) : sterge , nu din front trimitem
          "url": "string"
        });
  }

  Future<Either<Failure<String>, Map<String, dynamic>>> createCustomRole({
    required String name,
    required String organizationId,
  }) async {
    return ApiService().dioPost<Map<String, dynamic>>(
        url: EndpointConstants.baseUrl + EndpointConstants.createCustomRole,
        data: {
          "name": name,
          "organizationId": organizationId,
        });
  }

  Future<Either<Failure<String>, Map<String, dynamic>>> deleteAdmin(
      String email) async {
    return ApiService().dioPost<Map<String, dynamic>>(
      url: EndpointConstants.baseUrl + EndpointConstants.deleteAdmin(email),
    );
  }

  Future<Either<Failure<String>, Map<String, dynamic>>> updateAdminPassword(
      String email, String password) async {
    return ApiService().dioPost<Map<String, dynamic>>(
      url: EndpointConstants.baseUrl +
          EndpointConstants.updateAdminPassword(email, password),
    );
  }

  //
}
