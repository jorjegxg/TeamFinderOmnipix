part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterOrganizationAdminStarted extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String organizationName;
  final String organizationAddress;

  const RegisterOrganizationAdminStarted({
    required this.name,
    required this.email,
    required this.password,
    required this.organizationName,
    required this.organizationAddress,
  });

  @override
  List<Object> get props =>
      [email, password, organizationName, organizationAddress, name];
}

class RegisterEmployeeStarted extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String organizationId;

  const RegisterEmployeeStarted({
    required this.name,
    required this.email,
    required this.password,
    required this.organizationId,
  });

  @override
  List<Object> get props => [email, password, name, organizationId];
}

class LoginStarted extends AuthEvent {
  final String email;
  final String password;

  const LoginStarted({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class AuthLogoutRequested extends AuthEvent {
  final BuildContext context;
  const AuthLogoutRequested({required this.context});
}
