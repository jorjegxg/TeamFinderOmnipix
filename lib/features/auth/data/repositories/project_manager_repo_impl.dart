import "package:team_finder_app/core/exports/rest_imports.dart";

class ProjectManagerRepoImpl {
  Future<Either<Failure<String>, Map<String, dynamic>>> createProjectManager(
      String id) async {
    return ApiService().dioPost<Map<String, dynamic>>(
      url: EndpointConstants.baseUrl +
          EndpointConstants.createProjectManager(id),
    );
  }
}
