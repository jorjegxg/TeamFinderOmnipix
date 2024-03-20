import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/core/util/logger.dart';
import 'package:team_finder_app/features/auth/data/models/organization_admin_registration.dart';
import 'package:team_finder_app/features/auth/domain/auth_usecase.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departament_skills_provider.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_create/department_create_cubit.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_get/departments_get_cubit.dart';
import 'package:team_finder_app/features/project_pages/presentation/bloc/projects_bloc.dart';
import 'package:team_finder_app/features/project_pages/presentation/providers/add_member_provider.dart';
import 'package:team_finder_app/features/project_pages/presentation/providers/create_project_provider.dart';
import 'package:team_finder_app/features/project_pages/presentation/providers/edit_project_provider.dart';
import 'package:team_finder_app/features/settings/presentation/providers/profile_provider.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase authUsecase;

  final DepartamentSkillsProvider departamentSkillsProvider;
  final AddMembersProvider addMembersProvider;
  final CreateProjectProvider createProjectProvider;
  final EditProjectProvider editProjectProvider;
  final ProfileProvider profileProvider;
  final ProjectsBloc projectsBloc;
  final DepartmentCreateCubit departmentCreateCubit;
  final DepartmentsGetCubit departmentsGetCubit;

  AuthBloc(
    this.authUsecase,
    this.departamentSkillsProvider,
    this.addMembersProvider,
    this.createProjectProvider,
    this.editProjectProvider,
    this.profileProvider,
    this.projectsBloc,
    this.departmentCreateCubit,
    this.departmentsGetCubit,
  ) : super(AuthInitial()) {
    on<RegisterOrganizationAdminStarted>(_onRegisterOrganizationAdminStarted);
    on<RegisterEmployeeStarted>(_onRegisterEmployeeStarted);
    on<LoginStarted>(_onLoginStarted);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onRegisterOrganizationAdminStarted(
      RegisterOrganizationAdminStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    (await authUsecase.registerOrganizationAdmin(
      context: event.context,
      orgAdminRegistrationFields: OrgAdminRegistrationFields(
        name: event.name,
        email: event.email,
        password: event.password,
        organizationName: event.organizationName,
        organizationAddress: event.organizationAddress,
      ),
    ))
        .fold(
      (failure) {
        emit(
          AuthError(message: failure.message),
        );
      },
      (userId) {
        emit(AuthSuccess(
          userId: userId,
        ));
        logStoredData();
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
        emit(AuthSuccess(
          userId: userId,
        ));
        logStoredData();
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
        emit(AuthSuccess(
          userId: userId,
        ));
        logStoredData();
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
        clearDataFromProviders();
        emit(AuthInitial());
        logStoredData();
      },
    );
  }

  void clearDataFromProviders() {
    departamentSkillsProvider.clearAllData();
    addMembersProvider.clearAllData();
    createProjectProvider.clearAllData();

    editProjectProvider.clearAllData();
    profileProvider.clearAllData();
    projectsBloc.add(const ResetProjects());
    departmentCreateCubit.clearAllData();
    departmentsGetCubit.clearAllData();
  }
}

Future<void> logStoredData() async {
  // final token = await SecureStorageService().read(key: StorageConstants.token);

  //from hive
  var box = Hive.box<String>(HiveConstants.authBox);

  final userId = box.get(HiveConstants.userId);
  final organizationId = box.get(HiveConstants.organizationId);
  final userEmail = box.get(HiveConstants.userEmail);
  final departmentId = box.get(HiveConstants.departmentId);

  Logger.info('Stored data',
      ' userId: $userId, organizationId: $organizationId, userEmail: $userEmail, departmentId: $departmentId');
}
