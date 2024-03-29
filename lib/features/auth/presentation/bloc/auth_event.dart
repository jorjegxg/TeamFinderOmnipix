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
  final BuildContext context;

  const RegisterOrganizationAdminStarted({
    required this.name,
    required this.email,
    required this.password,
    required this.organizationName,
    required this.organizationAddress,
    required this.context,
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
  final BuildContext context;

  const RegisterEmployeeStarted({
    required this.name,
    required this.email,
    required this.password,
    required this.organizationId,
    required this.context,
  });

  @override
  List<Object> get props => [email, password, name, organizationId];
}

class LoginStarted extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  const LoginStarted({
    required this.email,
    required this.password,
    required this.context,
  });

  @override
  List<Object> get props => [email, password, context];
}

class AuthLogoutRequested extends AuthEvent {
  final BuildContext context;
  const AuthLogoutRequested({required this.context});
}

class AuthReset extends AuthEvent {
  const AuthReset();
}
