import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/auth/domain/auth_usecase.dart';

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
    ))
        .fold(
      (l) {
        emit(AuthError(message: l.message));
      },
      (r) {
        emit(AuthSuccess());
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
    ))
        .fold(
      (l) {
        emit(AuthError(message: l.message));
      },
      (r) {
        emit(AuthSuccess());
      },
    );
  }

  Future<void> _onLoginStarted(
      LoginStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    (await authUsecase.login(
      email: event.email,
      password: event.password,
    ))
        .fold(
      (l) {
        emit(AuthError(message: l.message));
      },
      (r) {
        emit(AuthSuccess());
      },
    );

    emit(AuthSuccess());
  }
}
