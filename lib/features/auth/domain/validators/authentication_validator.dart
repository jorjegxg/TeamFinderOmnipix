import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/features/auth/data/models/organization_admin_registration.dart';

@injectable
class AuthenticationValidator {
  bool _isEmailValid(String? email) {
    final bool emailValid;
    if (email == null || email.isEmpty) {
      emailValid = false;
    } else {
      emailValid = RegExp(
        RegexConstants.email,
      ).hasMatch(email);
    }
    return emailValid;
  }

  bool _isPasswordValid(String? password) {
    if (password == null || password.isEmpty || password.length < 6) {
      return false;
    }
    return true;
  }

  bool isOrganizationNameValid(String? organizationName) {
    if (organizationName == null || organizationName.isEmpty) {
      return false;
    }
    return true;
  }

  bool isOrganizationAddressValid(String? organizationAddress) {
    if (organizationAddress == null || organizationAddress.isEmpty) {
      return false;
    }
    return true;
  }

  bool isNameValid(String? name) {
    if (name == null || name.isEmpty) {
      return false;
    }
    return true;
  }

  Either<Failure<String>, void> areRegisterAdminInformationValid(
      OrgAdminRegistrationFields orgAdminRegistrationFields) {
    if (!isNameValid(orgAdminRegistrationFields.name)) {
      return Left(
        FieldFailure(message: 'Invalid name'),
      );
    } else if (!_isEmailValid(orgAdminRegistrationFields.email)) {
      return Left(
        FieldFailure(message: 'Invalid email'),
      );
    } else if (!_isPasswordValid(orgAdminRegistrationFields.password)) {
      return Left(
        FieldFailure(message: 'Invalid password'),
      );
    } else if (!isOrganizationNameValid(
        orgAdminRegistrationFields.organizationName)) {
      return Left(
        FieldFailure(message: 'Invalid organization name'),
      );
    } else if (!isOrganizationAddressValid(
        orgAdminRegistrationFields.organizationAddress)) {
      return Left(
        FieldFailure(message: 'Invalid organization address'),
      );
    }
    return const Right(null);
  }

  Either<Failure<String>, void> areRegisterEmployeeInformationValid(
    String? name,
    String? email,
    String? password,
  ) {
    if (!isNameValid(name)) {
      return Left(
        FieldFailure(message: 'Invalid name'),
      );
    } else if (!_isEmailValid(email)) {
      return Left(
        FieldFailure(message: 'Invalid email'),
      );
    } else if (!_isPasswordValid(password)) {
      return Left(
        FieldFailure(message: 'Invalid password'),
      );
    }

    return const Right(null);
  }

  Either<Failure<String>, void> areLoginInformationValid(
    String? email,
    String? password,
  ) {
    if (!_isEmailValid(email)) {
      return Left(
        FieldFailure(message: 'Invalid email'),
      );
    } else if (!_isPasswordValid(password)) {
      return Left(
        FieldFailure(message: 'Invalid password'),
      );
    }
    return const Right(null);
  }
}
