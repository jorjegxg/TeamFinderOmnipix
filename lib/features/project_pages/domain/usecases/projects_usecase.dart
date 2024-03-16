import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/features/project_pages/data/models/project_model.dart';
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

  Future<Either<Failure<String>, void>> createProject(
      {required ProjectModel newProject}) async {
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
}
