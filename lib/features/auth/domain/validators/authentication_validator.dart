import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/error/failures.dart';

@injectable
class AuthenticationValidator {
  bool _isEmailValid(String? email) {
    final bool emailValid;
    if (email == null || email.isEmpty) {
      emailValid = false;
    } else {
      emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
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

  Either<Failure<String>, void> areSignUpInformationValid(
    String? name,
    String? email,
    String? password,
    String? organizationName,
    String? organizationAddress,
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
    } else if (!isOrganizationNameValid(organizationName)) {
      return Left(
        FieldFailure(message: 'Invalid organization name'),
      );
    } else if (!isOrganizationAddressValid(organizationAddress)) {
      return Left(
        FieldFailure(message: 'Invalid organization address'),
      );
    }
    return const Right(null);
  }

  Either<Failure<String>, void> areLoginInformationValid(
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
}
