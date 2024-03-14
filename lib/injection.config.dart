// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:team_finder_app/core/routes/app_route_config.dart' as _i12;
import 'package:team_finder_app/features/auth/data/repositories/auth_repo_impl.dart'
    as _i4;
import 'package:team_finder_app/features/auth/domain/auth_usecase.dart' as _i16;
import 'package:team_finder_app/features/auth/domain/repositories/auth_repo.dart'
    as _i3;
import 'package:team_finder_app/features/auth/domain/validators/authentication_validator.dart'
    as _i5;
import 'package:team_finder_app/features/auth/presentation/bloc/auth_bloc.dart'
    as _i20;
import 'package:team_finder_app/features/departaments_pages/data/department_repository_impl.dart'
    as _i6;
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart'
    as _i7;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_create/department_create_cubit.dart'
    as _i17;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_get/departments_get_cubit.dart'
    as _i8;
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_managers/departments_managers_cubit.dart'
    as _i9;
import 'package:team_finder_app/features/employee_pages/data/employee_repo_impl.dart'
    as _i10;
import 'package:team_finder_app/features/employee_pages/domain/employee_usecase.dart'
    as _i11;
import 'package:team_finder_app/features/employee_pages/presentation/provider/employee_provider.dart'
    as _i18;
import 'package:team_finder_app/features/project_pages/data/repositories/project_repo_impl.dart'
    as _i14;
import 'package:team_finder_app/features/project_pages/domain/repositories/project_repo.dart'
    as _i13;
import 'package:team_finder_app/features/project_pages/domain/usecases/projects_usecase.dart'
    as _i15;
import 'package:team_finder_app/features/project_pages/presentation/bloc/projects_bloc.dart'
    as _i19;

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
    gh.singleton<_i12.MyAppRouter>(() => _i12.MyAppRouter());
    gh.lazySingleton<_i13.ProjectRepo>(() => _i14.ProjectRepoImpl());
    gh.factory<_i15.ProjectsUsecase>(
        () => _i15.ProjectsUsecase(gh<_i13.ProjectRepo>()));
    gh.singleton<_i16.AuthUsecase>(() => _i16.AuthUsecase(
          gh<_i5.AuthenticationValidator>(),
          gh<_i3.AuthRepo>(),
        ));
    gh.factory<_i17.DepartmentCreateCubit>(
        () => _i17.DepartmentCreateCubit(gh<_i7.DepartmentUseCase>()));
    gh.factory<_i18.EmployeeProvider>(
        () => _i18.EmployeeProvider(gh<_i11.EmployeeUsecase>()));
    gh.factory<_i19.ProjectsBloc>(
        () => _i19.ProjectsBloc(gh<_i15.ProjectsUsecase>()));
    gh.factory<_i20.AuthBloc>(() => _i20.AuthBloc(gh<_i16.AuthUsecase>()));
    return this;
  }
}
