import 'package:dartz/dartz.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/features/auth/data/models/organization_admin_registration.dart';

abstract class AuthRepo {
  Future<Either<Failure<String>, String>> registerOrganizationAdmin({
    required OrgAdminRegistrationFields orgAdminRegistrationFields,
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
