import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';
import 'package:team_finder_app/features/project_pages/data/models/project_model.dart';
import 'package:team_finder_app/features/project_pages/data/models/team_role.dart';
import 'package:team_finder_app/features/project_pages/data/models/technology_stack.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';
import 'package:team_finder_app/features/project_pages/domain/repositories/project_repo.dart';

@injectable
class ProjectsUsecase {
  final ProjectRepo projectRepo;

  ProjectsUsecase(this.projectRepo);

  Future<Either<Failure<String>, List<ProjectEntity>>>
      getCurrentUserActiveProjects() async {
    return projectRepo.getCurrentUserActiveProjects();
  }

  Future<Either<Failure<String>, List<ProjectEntity>>>
      getCurrentUserInActiveProjects() async {
    return projectRepo.getCurrentUserInActiveProjects();
  }

  Either<Failure<String>, void> verifyProject(ProjectModel project) {
    if (project.name.isEmpty) {
      return Left(FieldFailure(message: 'Project name is empty'));
    }
    if (project.deadlineDate.isBefore(project.startDate)) {
      return Left(FieldFailure(message: 'Deadline date is before start date'));
    }
    //TODO George Luta : trebuie sa facem verificare pentru technologyStack si teamRoles ?
    // if (project.technologyStack.isEmpty) {
    //   return Left(FieldFailure(message: 'Technology stack is empty'));
    // }

    // if (project.teamRoles.isEmpty) {
    //   return Left(FieldFailure(message: 'Team roles are empty'));
    // }
    if (project.description.isEmpty) {
      return Left(FieldFailure(message: 'Project description is empty'));
    }

    return const Right(null);
  }

  Future<Either<Failure<String>, void>> createProject(
      {required ProjectModel newProject}) async {
    final projectVerification = verifyProject(newProject);

    if (projectVerification.isLeft()) {
      return projectVerification;
    }

    for (var tech in newProject.technologyStack) {
      if (tech.id == '' || tech.id.isEmpty) {
        final response =
            await projectRepo.createTechnology(newTechnology: tech);
        response.fold(
          (l) {
            return Left(l);
          },
          (r) {
            tech.id = r;
          },
        );
      }
    }

    return projectRepo.createProject(newProject: newProject);
  }

  //get team roles
  Future<Either<Failure<String>, List<TeamRole>>> getTeamRoles() async {
    return projectRepo.getTeamRoles();
  }

  //get technology stack
  Future<Either<Failure<String>, List<TechnologyStack>>>
      getTechnologyStack() async {
    return projectRepo.getTechnologyStack();
  }

  //edit project
  Future<Either<Failure<String>, void>> editProject(
      {required ProjectEntity editedProject}) async {
    for (var tech in editedProject.technologyStack) {
      if (tech.id == '' || tech.id.isEmpty) {
        final response =
            await projectRepo.createTechnology(newTechnology: tech);
        response.fold(
          (l) {
            return Left(l);
          },
          (r) {
            tech.id = r;
          },
        );
      }
    }
    return projectRepo.editProject(editedProject: editedProject);
  }

  //deleteProject
  Future<Either<Failure<String>, void>> deleteProject(
      {required String projectId}) async {
    return projectRepo.deleteProject(projectId: projectId);
  }

  //getActiveMembers
  Future<Either<Failure<String>, List<Employee>>> getActiveMembers(
      String projectId) async {
    return projectRepo.getActiveMembers(projectId);
  }

  //getInActiveMembers
  Future<Either<Failure<String>, List<Employee>>> getInActiveMembers(
      String projectId) async {
    return projectRepo.getInActiveMembers(projectId);
  }

  //getFutureMembers
  Future<Either<Failure<String>, List<Employee>>> getFutureMembers(
      String projectId) async {
    return projectRepo.getFutureMembers(projectId);
  }

  //fetchFullyAvalibleMembers
  Future<Either<Failure<String>, List<Employee>>> fetchFullyAvalibleMembers(
      String projectId) async {
    return projectRepo.fetchFullyAvalibleMembers(projectId);
  }

  //fetch unavailable members

  Future<Either<Failure<String>, List<Employee>>> fetchUnavailableMembers(
      String projectId) async {
    return projectRepo.fetchUnavailableMembers(projectId);
  }

  //fetch partialy avabile members
  Future<Either<Failure<String>, List<Employee>>> fetchPartialyAvabileMembers(
      String projectId) async {
    return projectRepo.fetchPartialyAvabileMembers(projectId);
  }

  //getSkills
  Future<Either<Failure<String>, List<Skill>>> getSkills() async {
    return projectRepo.getSkills();
  }

  //post skill req
  Future<Either<Failure<String>, void>> postSkillReq(
      {required String projectId, required Map<String, int> skill}) async {
    return projectRepo.postSkillReq(projectId: projectId, skill: skill);
  }

  //fetch members with chatGPT
  Future<Either<Failure<String>, List<Employee>>> fetchMembersWithChatGPT(
      String message) async {
    return projectRepo.fetchMembersWithChatGPT(message: message);
  }

  //sendProposal({required ProjectEntity project, required String proposal, required int workHours, required List<TeamRole> teamRoles}) {}
  Future<Either<Failure<String>, void>> sendProposal({
    required ProjectEntity project,
    required String proposal,
    required int workHours,
    required List<TeamRole> teamRoles,
    required String projectId,
  }) async {
    return projectRepo.sendProposal(
      project: project,
      proposal: proposal,
      workHours: workHours,
      teamRoles: teamRoles,
      employeeId: projectId,
    );
  }

  //send dealocationProposal
  Future<Either<Failure<String>, void>> sendDealocationProposal(
      {required String projectId,
      required String proposal,
      required String employeeId}) async {
    return projectRepo.sendDealocationProposal(
      projectId: projectId,
      proposal: proposal,
      employeeId: employeeId,
    );
  }

 
  Future<Either<Failure<String>, bool>> canBeDeleted(String projectId) async {
    return projectRepo.canBeDeleted(projectId);
  }
}
