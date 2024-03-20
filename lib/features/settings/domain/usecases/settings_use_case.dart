import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';
import 'package:team_finder_app/features/settings/data/models/role_model.dart';
import 'package:team_finder_app/features/settings/data/repositories/settings_repo_impl.dart';

@injectable
class SettingsUseCase {
  final SettingsRepoImpl _repository;

  SettingsUseCase(this._repository);

  //get team roles with either
  Future<Either<Failure, List<RoleModel>>> getTeamRoles() async {
    return _repository.getTeamRoles();
  }

  //add team role
  Future<Either<Failure, void>> addTeamRole(RoleModel role) async {
    return _repository.addTeamRole(role);
  }

  //delete team role
  Future<Either<Failure, String>> deleteTeamRole(RoleModel role) async {
    return _repository.deleteTeamRole(role);
  }

  //get skills
  Future<Either<Failure, List<Skill>>> getFreeSkills() async {
    return _repository.getFreeSkills();
  }

  //add skill
  Future<Either<Failure, void>> addSkill(
    String skillId,
    int level,
    int experience,
    List<Map<String, String>> endorsments,
    List<String> projectsIds,
  ) async {
    return _repository.addSkillToEmployee(
      skillId,
      level,
      experience,
      endorsments,
      projectsIds,
    );
  }

  Future<Either<Failure<String>, List<Skill>>> getSkillsForEmployee() async {
    return _repository.getSkillsForEmployee();
  }

  Future<Either<Failure<String>, List<Skill>>> getOwnedSkills() async {
    return _repository.getOwnedSkills();
  }

  //getCure
  Future<Either<Failure, Employee>> getCurrentEmployee() async {
    return _repository.getCurrentEmployee();
  }

  //updateNameAndEmail
  Future<Either<Failure, void>> updateNameAndEmail(
      String name, String email) async {
    if (name.isEmpty || email.isEmpty) {
      return left(EasyFailure(message: "Name and email can't be empty"));
    }

    final emailValid = RegExp(RegexConstants.email).hasMatch(email);

    if (!emailValid) {
      return left(EasyFailure(message: "Invalid email"));
    }

    return _repository.updateNameAndEmail(name, email);
  }

  //changePassword
  Future<Either<Failure, void>> changePassword(
      String newPassword, String newPassword2, String email) async {
    if (newPassword.isEmpty || newPassword2.isEmpty) {
      return left(EasyFailure(message: "Password can't be empty"));
    } else if (newPassword.length < 6) {
      return left(
          EasyFailure(message: "Password must be at least 6 characters"));
    } else if (newPassword != newPassword2) {
      return left(EasyFailure(message: "Passwords do not match"));
    }

    return _repository.changePassword(newPassword, email);
  }

  //deleteSkill
  Future<Either<Failure<String>, void>> deleteOwnedSkill(Skill skill) async {
    return _repository.deleteOwnedSkill(skill);
  }

  Future<Either<Failure<String>, void>> editRole(RoleModel roleModel) async {
    return _repository.editRole(roleModel);
  }
}
