import 'package:dartz/dartz.dart';
import 'package:team_finder_app/core/error/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure<String>, String>> registerOrganizationAdmin({
    required String name,
    required String email,
    required String password,
    required String organizationName,
    required String organizationAddress,
  });

  Future<Either<Failure<String>, String>> registerEmployee({
    required String name,
    required String email,
    required String password,
    required String organizationId,
  });

  Future<Either<Failure<String>, String>> login(
      {required String email, required String password});

  Future<Either<Failure<String>, void>> deleteAllStoredData();

  Future<Either<Failure<String>, String>> getOrganizationName(
      String organizationId);
}
