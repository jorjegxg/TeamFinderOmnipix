import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/core/util/secure_storage_service.dart';
import 'package:team_finder_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:team_finder_app/features/auth/domain/validators/authentication_validator.dart';
import 'package:team_finder_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departament_skills_provider.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_create/department_create_cubit.dart';
import 'package:team_finder_app/features/employee_pages/presentation/provider/employee_roles_provider.dart';
import 'package:team_finder_app/features/project_pages/presentation/providers/add_member_provider.dart';
import 'package:team_finder_app/features/project_pages/presentation/providers/create_project_provider.dart';
import 'package:team_finder_app/features/project_pages/presentation/providers/edit_project_provider.dart';
import 'package:team_finder_app/features/project_pages/presentation/bloc/projects_bloc.dart';
import 'package:team_finder_app/features/settings/presentation/providers/profile_provider.dart';

@singleton
class AuthUsecase {
  final AuthenticationValidator fieldValidator;
  final AuthRepo authRepo;

  AuthUsecase(this.fieldValidator, this.authRepo);

  //if validation fails, return that failure
  Future<Either<Failure<String>, String>> registerOrganizationAdmin({
    required String name,
    required String email,
    required String password,
    required String organizationName,
    required String organizationAddress,
    required BuildContext context,
  }) async {
    return fieldValidator
        .areRegisterAdminInformationValid(
      name,
      email,
      password,
      organizationName,
      organizationAddress,
    )
        .fold(left, (r) async {
      final authResponse = await authRepo.registerOrganizationAdmin(
        name: name.trim(),
        email: email.trim(),
        password: password,
        organizationName: organizationName.trim(),
        organizationAddress: organizationAddress.trim(),
      );

      return authResponse.fold(
        left,
        (r) async {
          SecureStorageService().write(key: StorageConstants.token, value: r);
          final userData = await _saveLocalData(r);

          return right(userData['id']);
        },
      );
    });
  }

  Future<Map<String, dynamic>> _saveLocalData(String r) async {
    final userData = JwtDecoder.decode(r);

    var box = Hive.box<String>(HiveConstants.authBox);

    box.put(HiveConstants.userId, userData['id']);
    box.put(HiveConstants.organizationId, userData['organizationId']);
    box.put(HiveConstants.userEmail, userData['email']);
    if (userData['departmentId'] != null) {
      box.put(HiveConstants.departmentId, userData['departmentId']);
    }
    return userData;
  }

  Future<Either<Failure<String>, String>> registerEmployee({
    required String name,
    required String email,
    required String password,
    required String organizationId,
    required BuildContext context,
  }) async {
    return fieldValidator
        .areRegisterEmployeeInformationValid(
      name,
      email,
      password,
    )
        .fold(
      left,
      (r) async {
        final authResponse = await authRepo.registerEmployee(
          name: name.trim(),
          email: email.trim(),
          password: password,
          organizationId: organizationId,
        );

        return authResponse.fold(
          left,
          (r) async {
            SecureStorageService().write(key: StorageConstants.token, value: r);
            final userData = await _saveLocalData(r);

            return right(userData['id']);
          },
        );
      },
    );
  }

  Future<Either<Failure<String>, String>> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    return fieldValidator.areLoginInformationValid(email, password).fold(
      left,
      (r) async {
        final authResponse = await authRepo.login(
          email: email.trim(),
          password: password,
        );

        return authResponse.fold(
          left,
          (r) async {
            SecureStorageService().write(key: StorageConstants.token, value: r);

            final userData = await _saveLocalData(r);

            return right(userData['id']);
          },
        );
      },
    );
  }

  Future<Either<Failure<String>, void>> logout(
      {required BuildContext context}) async {
    return (await authRepo.deleteAllStoredData()).fold(
      (l) => left(l),
      (r) async {
        context.goNamed(
          AppRouterConst.registerAdminName,
        );
        return right(r);
      },
    );
  }

  Future<Either<Failure<String>, String>> getOrganizationName(
      {required String organizationId}) async {
    return authRepo.getOrganizationName(
      organizationId,
    );
  }
}
