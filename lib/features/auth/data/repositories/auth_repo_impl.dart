import 'package:firebase_messaging/firebase_messaging.dart';
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
    final deleteStoredDataRequest = await deleteAllStoredData();

    if (deleteStoredDataRequest.isLeft()) {
      return left(StorageFailure<String>(message: "Error deleting data"));
    }

    return (await ApiService().dioPost(
      url: "${EndpointConstants.baseUrl}/admin/create",
      data: {
        "name": name,
        "email": email,
        "password": password,
        "organizationName": organizationName,
        "adress": organizationAddress,
        //TODO George Luta : degeaba , scoate din back
        "url": "url"
      },
      codeMessage: {
        409: "Email already in use",
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

    if (deleteStoredDataRequest.isLeft()) {
      return left(StorageFailure<String>(message: "Error deleting data"));
    }

    return (await ApiService().dioPost(
      url: "${EndpointConstants.baseUrl}/employee/create",
      data: {
        "name": name,
        "email": email,
        "password": password,
        "organizationId": organizationId,
      },
      codeMessage: {
        409: "Email already in use",
      },
    ))
        .fold((l) => left(l), (r) {
      final token = r["Token"];

      Logger.info('AuthRepoImpl.registerEmployee',
          'token: ${JwtDecoder.decode(token)}');

      return right(token);
    });
  }

  @override
  Future<Either<Failure<String>, String>> login(
      {required String email, required String password}) async {
    final deleteStoredDataRequest = await deleteAllStoredData();

    if (deleteStoredDataRequest.isLeft()) {
      return left(StorageFailure<String>(message: "Error deleting data"));
    }

    return (await ApiService().dioPost(
      url: "${EndpointConstants.baseUrl}/login/",
      data: {
        "email": email,
        "password": password,
      },
      codeMessage: {
        400: "Invalid email or password",
        404: "User not found",
      },
    ))
        .fold((l) => left(l), (r) => right(r["Token"]));
  }

  @override
  Future<Either<Failure<String>, void>> deleteAllStoredData() async {
    try {
      await SecureStorageService().delete(key: StorageConstants.token);
      var box = Hive.box<String>(HiveConstants.authBox);
      final departmentId = box.get(HiveConstants.departmentId);

      await unsubscribeFromTopics(departmentId);

      await box.clear();
      Logger.success('Stored data deleteAllStoredData', 'deleted data');
    } catch (e) {
      return left(StorageFailure<String>(message: e.toString()));
    }

    return right(null);
  }

  Future<void> unsubscribeFromTopics(String? departmentId) async {
    if (departmentId != null) {
      await FirebaseMessaging.instance.unsubscribeFromTopic(departmentId);
    }
  }

  @override
  Future<Either<Failure<String>, String>> getOrganizationName(
      String organizationId) async {
    return (await ApiService().dioGet(
      url: "${EndpointConstants.baseUrl}/organization/$organizationId",
      codeMessage: {
        404: "Organization not found",
      },
    ))
        .fold((l) => left(l), (r) => right(r["name"]));
  }
}
