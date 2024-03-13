import 'package:dartz/dartz.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/features/project_pages/data/models/project_model.dart';

abstract class ProjectRepo {
  Future<Either<Failure<String>, List<ProjectModel>>> getCurrentUserProjects();
}
