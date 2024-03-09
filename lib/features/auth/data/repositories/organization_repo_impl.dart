import "package:team_finder_app/core/exports/rest_imports.dart";

class OrganizationRepoImpl {
  Future<Either<Failure<String>, String>> createOrganization({
    required String name,
    required String adress,
    required String entranceUrl,
  }) async {
    return ApiService().dioPost<String>(
        url: EndpointConstants.baseUrl + EndpointConstants.createOrganization,
        data: {
          "name": name,
          "adress": adress,
          "entranceUrl": entranceUrl,
        });
  }
}
