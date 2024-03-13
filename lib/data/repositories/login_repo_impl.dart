import "package:team_finder_app/core/exports/rest_imports.dart";

class LoginRepoImpl {
  Future<Either<Failure<String>, Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    return ApiService().dioPost(
        url: EndpointConstants.baseUrl + EndpointConstants.login,
        data: {
          "email": email,
          "password": password,
        });
  }
}
