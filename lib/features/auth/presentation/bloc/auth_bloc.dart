import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/util/logger.dart';
import 'package:team_finder_app/features/auth/domain/auth_usecase.dart';
import 'package:team_finder_app/features/employee_pages/presentation/provider/employee_roles_provider.dart';
import 'package:team_finder_app/injection.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase authUsecase;
  AuthBloc(
    this.authUsecase,
  ) : super(AuthInitial()) {
    on<RegisterOrganizationAdminStarted>(_onRegisterOrganizationAdminStarted);
    on<RegisterEmployeeStarted>(_onRegisterEmployeeStarted);
    on<LoginStarted>(_onLoginStarted);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthReset>(_clearData);
  }

  Future<void> _onRegisterOrganizationAdminStarted(
      RegisterOrganizationAdminStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    (await authUsecase.registerOrganizationAdmin(
      name: event.name,
      email: event.email,
      password: event.password,
      organizationName: event.organizationName,
      organizationAddress: event.organizationAddress,
      context: event.context,
    ))
        .fold(
      (failure) {
        emit(
          AuthError(message: failure.message),
        );
      },
      (userId) {
        getIt<EmployeeRolesProvider>().getCurrentEmployeeRoles();
        emit(AuthSuccess(
          userId: userId,
        ));
      },
    );
  }

  Future<void> _onRegisterEmployeeStarted(
      RegisterEmployeeStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    (await authUsecase.registerEmployee(
      name: event.name,
      email: event.email,
      password: event.password,
      organizationId: event.organizationId,
      context: event.context,
    ))
        .fold(
      (failure) {
        emit(AuthError(message: failure.message));
      },
      (userId) {
        getIt<EmployeeRolesProvider>().getCurrentEmployeeRoles();
        emit(AuthSuccess(
          userId: userId,
        ));
      },
    );
  }

  Future<void> _onLoginStarted(
      LoginStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    (await authUsecase.login(
      email: event.email,
      password: event.password,
      context: event.context,
    ))
        .fold(
      (failure) {
        emit(AuthError(message: failure.message));
      },
      (userId) {
        getIt<EmployeeRolesProvider>().getCurrentEmployeeRoles();
        emit(AuthSuccess(
          userId: userId,
        ));
      },
    );
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    (await authUsecase.logout(context: event.context)).fold(
      (failure) {
        emit(AuthError(message: failure.message));
      },
      (r) {
        emit(AuthInitial());
      },
    );
  }

  void _clearData(AuthReset event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }
}
