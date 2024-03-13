import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';
import 'package:team_finder_app/features/project_pages/domain/repositories/project_repo.dart';

@injectable
class ProjectsUsecase {
  final ProjectRepo projectRepo;

  ProjectsUsecase(this.projectRepo);

  Future<Either<Failure<String>, List<ProjectEntity>>>
      getCurrentUserProjects() async {
    return projectRepo.getCurrentUserProjects();
  }
}
