import 'package:dartz/dartz.dart';
import 'package:team_finder_app/core/error/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure<String>, void>> registerOrganizationAdmin({
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
}
