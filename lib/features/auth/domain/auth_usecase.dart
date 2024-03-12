import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:team_finder_app/features/auth/domain/validators/authentication_validator.dart';

@singleton
class AuthUsecase {
  final AuthenticationValidator fieldValidator;
  final AuthRepo authRepo;

  AuthUsecase(this.fieldValidator, this.authRepo);

  //if validation fails, return that failure
  Future<Either<Failure<String>, void>> registerOrganizationAdmin({
    required String name,
    required String email,
    required String password,
    required String organizationName,
    required String organizationAddress,
  }) async {
    return fieldValidator
        .areRegisterAdminInformationValid(
          name,
          email,
          password,
          organizationName,
          organizationAddress,
        )
        .fold(
          left,
          (r) => authRepo.registerOrganizationAdmin(
            name: name.trim(),
            email: email.trim(),
            password: password,
            organizationName: organizationName.trim(),
            organizationAddress: organizationAddress.trim(),
          ),
        );
  }

  Future<Either<Failure<String>, String>> registerEmployee({
    required String name,
    required String email,
    required String password,
    required String organizationId,
  }) async {
    return fieldValidator
        .areRegisterEmployeeInformationValid(
          name,
          email,
          password,
        )
        .fold(
          left,
          (r) => authRepo.registerEmployee(
            name: name.trim(),
            email: email.trim(),
            password: password,
            organizationId: organizationId,
          ),
        );
  }

  Future<Either<Failure<String>, String>> login(
      {required String email, required String password}) async {
    return fieldValidator.areLoginInformationValid(email, password).fold(
          left,
          (r) => authRepo.login(
            email: email.trim(),
            password: password,
          ),
        );
  }
}
