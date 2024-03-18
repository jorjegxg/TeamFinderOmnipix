// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:team_finder_app/core/routes/app_route_config.dart' as _i13;
import 'package:team_finder_app/features/auth/data/repositories/auth_repo_impl.dart'
    as _i4;
import 'package:team_finder_app/features/auth/domain/auth_usecase.dart' as _i23;
import 'package:team_finder_app/features/auth/domain/repositories/auth_repo.dart'
    as _i3;
import 'package:team_finder_app/features/auth/domain/validators/authentication_validator.dart'
    as _i5;
import 'package:team_finder_app/features/auth/presentation/bloc/auth_bloc.dart'
    as _i34;
import 'package:team_finder_app/features/departaments_pages/data/department_repository_impl.dart'
    as _i6;
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart'
    as _i7;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/add_employee_departament_provider.dart'
    as _i22;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/create_skill_provider.dart'
    as _i25;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departament_employees_provider.dart'
    as _i26;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departament_projects_provider.dart'
    as _i27;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departament_skills_provider.dart'
    as _i28;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_create/department_create_cubit.dart'
    as _i29;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_get/departments_get_cubit.dart'
    as _i8;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_managers/departments_managers_cubit.dart'
    as _i9;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/skill_statistics_provider.dart'
    as _i20;
import 'package:team_finder_app/features/employee_pages/data/employee_repo_impl.dart'
    as _i10;
import 'package:team_finder_app/features/employee_pages/domain/employee_usecase.dart'
    as _i11;
import 'package:team_finder_app/features/employee_pages/presentation/provider/edit_employee_provider.dart'
    as _i30;
import 'package:team_finder_app/features/employee_pages/presentation/provider/employees_provider.dart'
    as _i12;
import 'package:team_finder_app/features/project_pages/data/repositories/project_repo_impl.dart'
    as _i15;
import 'package:team_finder_app/features/project_pages/domain/repositories/project_repo.dart'
    as _i14;
import 'package:team_finder_app/features/project_pages/domain/usecases/projects_usecase.dart'
    as _i16;
import 'package:team_finder_app/features/project_pages/presentation/bloc/create_project_provider.dart'
    as _i24;
import 'package:team_finder_app/features/project_pages/presentation/bloc/projects_bloc.dart'
    as _i33;
import 'package:team_finder_app/features/settings/data/repositories/settings_repo_impl.dart'
    as _i17;
import 'package:team_finder_app/features/settings/domain/usecases/settings_use_case.dart'
    as _i18;
import 'package:team_finder_app/features/settings/presentation/providers/add_skill_provider.dart'
    as _i19;
import 'package:team_finder_app/features/settings/presentation/providers/personal_skills_provider.dart'
    as _i31;
import 'package:team_finder_app/features/settings/presentation/providers/profile_provider.dart'
    as _i32;
import 'package:team_finder_app/features/settings/presentation/providers/team_roles_provider.dart'
    as _i21;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AuthRepo>(() => _i4.AuthRepoImpl());
    gh.factory<_i5.AuthenticationValidator>(
        () => _i5.AuthenticationValidator());
    gh.factory<_i6.DepartmentRepositoryImpl>(
        () => _i6.DepartmentRepositoryImpl());
    gh.factory<_i7.DepartmentUseCase>(
        () => _i7.DepartmentUseCase(gh<_i6.DepartmentRepositoryImpl>()));
    gh.factory<_i8.DepartmentsGetCubit>(
        () => _i8.DepartmentsGetCubit(gh<_i7.DepartmentUseCase>()));
    gh.factory<_i9.DepartmentsManagersCubit>(
        () => _i9.DepartmentsManagersCubit(gh<_i7.DepartmentUseCase>()));
    gh.factory<_i10.EmployeeRepoImpl>(() => _i10.EmployeeRepoImpl());
    gh.factory<_i11.EmployeeUsecase>(
        () => _i11.EmployeeUsecase(gh<_i10.EmployeeRepoImpl>()));
    gh.factory<_i12.EmployeesProvider>(
        () => _i12.EmployeesProvider(gh<_i11.EmployeeUsecase>()));
    gh.singleton<_i13.MyAppRouter>(() => _i13.MyAppRouter());
    gh.lazySingleton<_i14.ProjectRepo>(() => _i15.ProjectRepoImpl());
    gh.factory<_i16.ProjectsUsecase>(
        () => _i16.ProjectsUsecase(gh<_i14.ProjectRepo>()));
    gh.factory<_i17.SettingsRepoImpl>(() => _i17.SettingsRepoImpl());
    gh.factory<_i18.SettingsUseCase>(
        () => _i18.SettingsUseCase(gh<_i17.SettingsRepoImpl>()));
    gh.factory<_i19.SkillAssignmentProvider>(
        () => _i19.SkillAssignmentProvider(gh<_i18.SettingsUseCase>()));
    gh.factory<_i20.SkillStatisticsProvider>(
        () => _i20.SkillStatisticsProvider(gh<_i7.DepartmentUseCase>()));
    gh.factory<_i21.TeamRolesProvider>(
        () => _i21.TeamRolesProvider(gh<_i18.SettingsUseCase>()));
    gh.factory<_i22.AddEmployeeToDepartamentProvider>(() =>
        _i22.AddEmployeeToDepartamentProvider(gh<_i7.DepartmentUseCase>()));
    gh.singleton<_i23.AuthUsecase>(() => _i23.AuthUsecase(
          gh<_i5.AuthenticationValidator>(),
          gh<_i3.AuthRepo>(),
        ));
    gh.factory<_i24.CreateProjectProvider>(
        () => _i24.CreateProjectProvider(gh<_i16.ProjectsUsecase>()));
    gh.factory<_i25.CreateSkillProvider>(
        () => _i25.CreateSkillProvider(gh<_i7.DepartmentUseCase>()));
    gh.factory<_i26.DepartamentEmployeesProvider>(
        () => _i26.DepartamentEmployeesProvider(gh<_i7.DepartmentUseCase>()));
    gh.factory<_i27.DepartamentProjectsProvider>(
        () => _i27.DepartamentProjectsProvider(gh<_i7.DepartmentUseCase>()));
    gh.factory<_i28.DepartamentSkillsProvider>(
        () => _i28.DepartamentSkillsProvider(gh<_i7.DepartmentUseCase>()));
    gh.factory<_i29.DepartmentCreateCubit>(
        () => _i29.DepartmentCreateCubit(gh<_i7.DepartmentUseCase>()));
    gh.factory<_i30.EditEmployeeProvider>(
        () => _i30.EditEmployeeProvider(gh<_i11.EmployeeUsecase>()));
    gh.factory<_i31.PersonalSkillsProvider>(
        () => _i31.PersonalSkillsProvider(gh<_i18.SettingsUseCase>()));
    gh.factory<_i32.ProfileProvider>(
        () => _i32.ProfileProvider(gh<_i18.SettingsUseCase>()));
    gh.factory<_i33.ProjectsBloc>(
        () => _i33.ProjectsBloc(gh<_i16.ProjectsUsecase>()));
    gh.factory<_i34.AuthBloc>(() => _i34.AuthBloc(gh<_i23.AuthUsecase>()));
    return this;
  }
}
