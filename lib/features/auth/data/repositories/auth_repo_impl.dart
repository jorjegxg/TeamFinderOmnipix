import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/core/util/logger.dart';
import 'package:team_finder_app/core/util/secure_storage_service.dart';
import 'package:team_finder_app/features/auth/domain/repositories/auth_repo.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  @override
  Future<Either<Failure<String>, String>> registerOrganizationAdmin({
    required String name,
    required String email,
    required String password,
    required String organizationName,
    required String organizationAddress,
  }) async {
    return (await ApiService().dioPost(
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
    ))
        .fold((l) => left(l), (r) => right(r["Token"]));
  }

  @override
  Future<Either<Failure<String>, String>> registerEmployee({
    required String name,
    required String email,
    required String password,
    required String organizationId,
  }) async {
    final deleteStoredDataRequest = await deleteAllStoredData();

    if (deleteStoredDataRequest.isRight()) {
      Logger.success('AuthRepoImpl.registerEmployee', 'deleted data');
      return (await ApiService().dioPost(
        url: "${EndpointConstants.baseUrl}/employee/create",
        data: {
          "name": name,
          "email": email,
          "password": password,
          "organizationId": organizationId,
        },
      ))
          .fold((l) => left(l), (r) {
        final token = r["Token"];

        Logger.info('AuthRepoImpl.registerEmployee',
            'token: ${JwtDecoder.decode(token)}');

        return right(token);
      });
    } else {
      return left(StorageFailure<String>(message: "Error deleting data"));
    }
  }

  @override
  Future<Either<Failure<String>, String>> login(
      {required String email, required String password}) async {
    return (await ApiService().dioPost(
      url: "${EndpointConstants.baseUrl}/login/",
      data: {
        "email": email,
        "password": password,
      },
    ))
        .fold((l) => left(l), (r) => right(r["Token"]));
  }

  @override
  Future<Either<Failure<String>, void>> deleteAllStoredData() async {
    try {
      await SecureStorageService().delete(key: StorageConstants.token);
      var box = Hive.box<String>(HiveConstants.authBox);
      await box.clear();
    } catch (e) {
      return left(StorageFailure<String>(message: e.toString()));
    }

    return right(null);
  }
}
