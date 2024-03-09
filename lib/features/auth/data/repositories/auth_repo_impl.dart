import 'package:dartz/dartz.dart';
import 'package:team_finder_app/core/api_service.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/core/util/constants.dart';

class AuthRepoImpl {
  Future<Either<Failure<String>, String>> createOrganizationAdminAccount({
    required String name,
    required String email,
    required String password,
    required String organizationName,
    required String address,
  }) async {
    return ApiService().dioPost<String>(
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
}
