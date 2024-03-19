import 'package:dartz/dartz.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';
import 'package:team_finder_app/features/project_pages/data/models/project_model.dart';
import 'package:team_finder_app/features/project_pages/data/models/team_role.dart';
import 'package:team_finder_app/features/project_pages/data/models/technology_stack.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';

abstract class ProjectRepo {
  Future<Either<Failure<String>, List<ProjectModel>>>
      getCurrentUserActiveProjects();
  Future<Either<Failure<String>, List<ProjectModel>>>
      getCurrentUserInActiveProjects();
  //create project
  Future<Either<Failure<String>, void>> createProject(
      {required ProjectModel newProject});

  //create technologie
  Future<Either<Failure<String>, String>> createTechnology(
      {required TechnologyStack newTechnology});

  //get team roles

  Future<Either<Failure<String>, List<TeamRole>>> getTeamRoles();

  //get technology stack
  Future<Either<Failure<String>, List<TechnologyStack>>> getTechnologyStack();

  //edit project
  Future<Either<Failure<String>, void>> editProject(
      {required ProjectEntity editedProject});

  //deleteProject
  Future<Either<Failure<String>, void>> deleteProject(
      {required String projectId});

  //get active members
  Future<Either<Failure<String>, List<Employee>>> getActiveMembers(
      String projectId);

  //get inactive members
  Future<Either<Failure<String>, List<Employee>>> getInActiveMembers(
      String projectId);

  //get future members
  Future<Either<Failure<String>, List<Employee>>> getFutureMembers(
      String projectId);

  //fetchFullyAvalibleMembers
  Future<Either<Failure<String>, List<Employee>>> fetchFullyAvalibleMembers(
      String projectId);

  //fetch unavailable members
  Future<Either<Failure<String>, List<Employee>>> fetchUnavailableMembers(
      String projectId);

  Future<Either<Failure<String>, List<Employee>>> fetchPartialyAvabileMembers(
      String projectId);

  Future<Either<Failure<String>, List<Skill>>> getSkills();

  //post skill req
  Future<Either<Failure<String>, void>> postSkillReq(
      {required String projectId, required Map<String, int> skill});

  //fetchMembersWithChatGPT
  Future<Either<Failure<String>, List<Employee>>> fetchMembersWithChatGPT(
      {required String message});

  Future<Either<Failure<String>, void>> sendProposal({
    required ProjectEntity project,
    required String proposal,
    required int workHours,
    required List<TeamRole> teamRoles,
    required String employeeId,
  });

  Future<Either<Failure<String>, void>> sendDealocationProposal(
      {required String projectId,
      required String proposal,
      required String employeeId});
}
