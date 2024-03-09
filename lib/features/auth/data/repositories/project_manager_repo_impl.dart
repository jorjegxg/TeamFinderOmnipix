import "package:team_finder_app/core/exports/rest_imports.dart";

class ProjectManagerRepoImpl {
  Future<Either<Failure<String>, String>> createProjectManager(
      String id) async {
    return ApiService().dioPost<String>(
      url:
          '${EndpointConstants.baseUrl}${EndpointConstants.createProjectManager(id)}',
    );
  }
}
