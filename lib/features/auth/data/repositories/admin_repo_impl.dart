import 'package:dartz/dartz.dart';
import 'package:team_finder_app/core/api_service.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/core/util/constants.dart';

class AdminRepoImpl {
  /**admin endpoints//
  static const String createAdmin = '/admin/create';
  {
  "name": "string",
  "email": "string",
  "password": "string",
  "organizationName": "string",
  "adress": "string",
  "url": "string"
}
  static const String createCustomRole = '/admin/customrole';
  {
  "name": "string",
  "organizationId": "string"
}
  static String deleteAdmin(String email) => '/admin/delete/$email';
  -
  static String updateAdminPassword(String email, String password) =>
      '/admin/updatePassword/$email/$password';
   -   
       */

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

  Future<Either<Failure<String>, String>> createCustomRole({
    required String name,
    required String organizationId,
  }) async {
    return ApiService().dioPost<String>(
        url: EndpointConstants.baseUrl + EndpointConstants.createCustomRole,
        data: {
          "name": name,
          "organizationId": organizationId,
        });
  }

  Future<Either<Failure<String>, String>> deleteAdmin(String email) async {
    return ApiService().dioPost<String>(
      url: EndpointConstants.baseUrl + EndpointConstants.deleteAdmin(email),
    );
  }

  Future<Either<Failure<String>, String>> updateAdminPassword(
      String email, String password) async {
    return ApiService().dioPost<String>(
      url: EndpointConstants.baseUrl +
          EndpointConstants.updateAdminPassword(email, password),
    );
  }

  //
}
