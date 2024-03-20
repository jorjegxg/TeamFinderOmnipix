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
import 'package:team_finder_app/features/auth/domain/auth_usecase.dart' as _i27;
import 'package:team_finder_app/features/auth/domain/repositories/auth_repo.dart'
    as _i3;
import 'package:team_finder_app/features/auth/domain/validators/authentication_validator.dart'
    as _i5;
import 'package:team_finder_app/features/auth/presentation/bloc/auth_bloc.dart'
    as _i44;
import 'package:team_finder_app/features/departaments_pages/data/department_repository_impl.dart'
    as _i6;
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart'
    as _i7;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/add_employee_departament_provider.dart'
    as _i25;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/delete_department_provider.dart'
    as _i29;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departament_confirmation_provider.dart'
    as _i30;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departament_employees_provider.dart'
    as _i31;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departament_projects_provider.dart'
    as _i32;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departament_skills_provider.dart'
    as _i33;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_create/department_create_cubit.dart'
    as _i34;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_get/departments_get_cubit.dart'
    as _i8;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_managers/departments_managers_cubit.dart'
    as _i9;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/skill_statistics_provider.dart'
    as _i22;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/validations_provider.dart'
    as _i24;
import 'package:team_finder_app/features/employee_pages/data/employee_repo_impl.dart'
    as _i10;
import 'package:team_finder_app/features/employee_pages/domain/employee_usecase.dart'
    as _i11;
import 'package:team_finder_app/features/employee_pages/presentation/provider/edit_employee_provider.dart'
    as _i36;
import 'package:team_finder_app/features/employee_pages/presentation/provider/employee_roles_provider.dart'
    as _i38;
import 'package:team_finder_app/features/employee_pages/presentation/provider/employees_provider.dart'
    as _i12;
import 'package:team_finder_app/features/project_pages/data/repositories/project_repo_impl.dart'
    as _i15;
import 'package:team_finder_app/features/project_pages/domain/repositories/project_repo.dart'
    as _i14;
import 'package:team_finder_app/features/project_pages/domain/usecases/projects_usecase.dart'
    as _i16;
import 'package:team_finder_app/features/project_pages/presentation/bloc/projects_bloc.dart'
    as _i43;
import 'package:team_finder_app/features/project_pages/presentation/providers/add_member_provider.dart'
    as _i26;
import 'package:team_finder_app/features/project_pages/presentation/providers/create_project_provider.dart'
    as _i45;
import 'package:team_finder_app/features/project_pages/presentation/providers/details_provider.dart'
    as _i35;
import 'package:team_finder_app/features/project_pages/presentation/providers/edit_project_provider.dart'
    as _i37;
import 'package:team_finder_app/features/project_pages/presentation/providers/project_members_provider.dart'
    as _i42;
import 'package:team_finder_app/features/project_pages/presentation/providers/send_proposal_provider.dart'
    as _i17;
import 'package:team_finder_app/features/project_pages/presentation/providers/skill_req_provider.dart'
    as _i21;
import 'package:team_finder_app/features/settings/data/repositories/settings_repo_impl.dart'
    as _i18;
import 'package:team_finder_app/features/settings/domain/usecases/settings_use_case.dart'
    as _i19;
import 'package:team_finder_app/features/settings/presentation/providers/add_skill_provider.dart'
    as _i20;
import 'package:team_finder_app/features/settings/presentation/providers/create_skill_provider.dart'
    as _i28;
import 'package:team_finder_app/features/settings/presentation/providers/owned_skills_provider.dart'
    as _i39;
import 'package:team_finder_app/features/settings/presentation/providers/personal_skills_provider.dart'
    as _i40;
import 'package:team_finder_app/features/settings/presentation/providers/profile_provider.dart'
    as _i41;
import 'package:team_finder_app/features/settings/presentation/providers/team_roles_provider.dart'
    as _i23;

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
    gh.singleton<_i8.DepartmentsGetCubit>(
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
    gh.factory<_i17.SendProposalProvider>(
        () => _i17.SendProposalProvider(gh<_i16.ProjectsUsecase>()));
    gh.factory<_i18.SettingsRepoImpl>(() => _i18.SettingsRepoImpl());
    gh.factory<_i19.SettingsUseCase>(
        () => _i19.SettingsUseCase(gh<_i18.SettingsRepoImpl>()));
    gh.factory<_i20.SkillAssignmentProvider>(
        () => _i20.SkillAssignmentProvider(gh<_i19.SettingsUseCase>()));
    gh.factory<_i21.SkillReqProvider>(
        () => _i21.SkillReqProvider(gh<_i16.ProjectsUsecase>()));
    gh.factory<_i22.SkillStatisticsProvider>(
        () => _i22.SkillStatisticsProvider(gh<_i7.DepartmentUseCase>()));
    gh.factory<_i23.TeamRolesProvider>(
        () => _i23.TeamRolesProvider(gh<_i19.SettingsUseCase>()));
    gh.factory<_i24.ValidationProvider>(
        () => _i24.ValidationProvider(gh<_i7.DepartmentUseCase>()));
    gh.factory<_i25.AddEmployeeToDepartamentProvider>(() =>
        _i25.AddEmployeeToDepartamentProvider(gh<_i7.DepartmentUseCase>()));
    gh.factory<_i26.AddMembersProvider>(
        () => _i26.AddMembersProvider(gh<_i16.ProjectsUsecase>()));
    gh.singleton<_i27.AuthUsecase>(() => _i27.AuthUsecase(
          gh<_i5.AuthenticationValidator>(),
          gh<_i3.AuthRepo>(),
        ));
    gh.factory<_i28.CreateSkillProvider>(
        () => _i28.CreateSkillProvider(gh<_i7.DepartmentUseCase>()));
    gh.factory<_i29.DeleteDepartmentProvider>(() =>
        _i29.DeleteDepartmentProvider(
            departmentUseCase: gh<_i7.DepartmentUseCase>()));
    gh.factory<_i30.DepartamentConfirmationProvider>(() =>
        _i30.DepartamentConfirmationProvider(gh<_i7.DepartmentUseCase>()));
    gh.factory<_i31.DepartamentEmployeesProvider>(
        () => _i31.DepartamentEmployeesProvider(gh<_i7.DepartmentUseCase>()));
    gh.factory<_i32.DepartamentProjectsProvider>(
        () => _i32.DepartamentProjectsProvider(gh<_i7.DepartmentUseCase>()));
    gh.factory<_i33.DepartamentSkillsProvider>(
        () => _i33.DepartamentSkillsProvider(gh<_i7.DepartmentUseCase>()));
    gh.factory<_i34.DepartmentCreateCubit>(
        () => _i34.DepartmentCreateCubit(gh<_i7.DepartmentUseCase>()));
    gh.factory<_i35.DetailsProvider>(
        () => _i35.DetailsProvider(gh<_i16.ProjectsUsecase>()));
    gh.factory<_i36.EditEmployeeProvider>(
        () => _i36.EditEmployeeProvider(gh<_i11.EmployeeUsecase>()));
    gh.factory<_i37.EditProjectProvider>(
        () => _i37.EditProjectProvider(gh<_i16.ProjectsUsecase>()));
    gh.singleton<_i38.EmployeeRolesProvider>(
        () => _i38.EmployeeRolesProvider(gh<_i11.EmployeeUsecase>()));
    gh.factory<_i39.OwnedSkillsProvider>(
        () => _i39.OwnedSkillsProvider(gh<_i19.SettingsUseCase>()));
    gh.factory<_i40.PersonalSkillsProvider>(
        () => _i40.PersonalSkillsProvider(gh<_i19.SettingsUseCase>()));
    gh.singleton<_i41.ProfileProvider>(
        () => _i41.ProfileProvider(gh<_i19.SettingsUseCase>()));
    gh.factory<_i42.ProjectMembersProvider>(
        () => _i42.ProjectMembersProvider(gh<_i16.ProjectsUsecase>()));
    gh.singleton<_i43.ProjectsBloc>(
        () => _i43.ProjectsBloc(gh<_i16.ProjectsUsecase>()));
    gh.factory<_i44.AuthBloc>(() => _i44.AuthBloc(gh<_i27.AuthUsecase>()));
    gh.factory<_i45.CreateProjectProvider>(() => _i45.CreateProjectProvider(
          projectsUsecase: gh<_i16.ProjectsUsecase>(),
          projectsBloc: gh<_i43.ProjectsBloc>(),
        ));
    return this;
  }
}
