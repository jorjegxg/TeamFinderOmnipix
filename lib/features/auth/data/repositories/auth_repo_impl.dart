import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/features/auth/domain/repositories/auth_repo.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  @override
  Future<Either<Failure<String>, void>> registerOrganizationAdmin({
    required String name,
    required String email,
    required String password,
    required String organizationName,
    required String organizationAddress,
  }) {
    return ApiService().dioPost<Map<String, dynamic>>(
      url: "${EndpointConstants.baseUrl}/admin/create",
      data: {
        "name": name,
        "email": email,
        "password": password,
        "organizationName": organizationName,
        "adress": organizationAddress,
        //TODO George Luta : nu trebuie facuta in front-end
        "url": "url"
      },
    );
  }

  @override
  Future<Either<Failure<String>, String>> registerEmployee({
    required String name,
    required String email,
    required String password,
    required String organizationId,
  }) async {
    return (await ApiService().dioPost<Map<String, dynamic>>(
      url: "${EndpointConstants.baseUrl}/employee/create",
      data: {
        "name": name,
        "email": email,
        "password": password,
        "organizationId": organizationId,
      },
    ))
        .fold((l) => left(l), (r) => right(r["Token"]));
  }

  @override
  Future<Either<Failure<String>, String>> login(
      {required String email, required String password}) async {
    return (await ApiService().dioPost<Map<String, dynamic>>(
      url: "${EndpointConstants.baseUrl}/login/",
      data: {
        "email": email,
        "password": password,
      },
    ))
        .fold((l) => left(l), (r) => right(r["Authentication successful"]));
  }
}
