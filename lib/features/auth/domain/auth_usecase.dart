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
        .areSignUpInformationValid(
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
}