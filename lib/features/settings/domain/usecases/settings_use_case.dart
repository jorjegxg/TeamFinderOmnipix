import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';
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
  Future<Either<Failure, void>> deleteTeamRole(RoleModel role) async {
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
}
