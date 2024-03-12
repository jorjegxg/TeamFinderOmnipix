// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:team_finder_app/core/routes/app_route_config.dart' as _i6;
import 'package:team_finder_app/features/auth/data/repositories/auth_repo_impl.dart'
    as _i4;
import 'package:team_finder_app/features/auth/domain/auth_usecase.dart' as _i10;
import 'package:team_finder_app/features/auth/domain/repositories/auth_repo.dart'
    as _i3;
import 'package:team_finder_app/features/auth/domain/validators/authentication_validator.dart'
    as _i5;
import 'package:team_finder_app/features/auth/presentation/bloc/auth_bloc.dart'
    as _i12;
import 'package:team_finder_app/features/project_pages/data/repositories/project_repo_impl.dart'
    as _i8;
import 'package:team_finder_app/features/project_pages/domain/repositories/project_repo.dart'
    as _i7;
import 'package:team_finder_app/features/project_pages/domain/usecases/projects_usecase.dart'
    as _i9;
import 'package:team_finder_app/features/project_pages/presentation/bloc/projects_bloc.dart'
    as _i11;

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
    gh.singleton<_i6.MyAppRouter>(() => _i6.MyAppRouter());
    gh.lazySingleton<_i7.ProjectRepo>(() => _i8.ProjectRepoImpl());
    gh.factory<_i9.ProjectsUsecase>(
        () => _i9.ProjectsUsecase(gh<_i7.ProjectRepo>()));
    gh.singleton<_i10.AuthUsecase>(() => _i10.AuthUsecase(
          gh<_i5.AuthenticationValidator>(),
          gh<_i3.AuthRepo>(),
        ));
    gh.factory<_i11.ProjectsBloc>(
        () => _i11.ProjectsBloc(gh<_i9.ProjectsUsecase>()));
    gh.factory<_i12.AuthBloc>(() => _i12.AuthBloc(gh<_i10.AuthUsecase>()));
    return this;
  }
}
