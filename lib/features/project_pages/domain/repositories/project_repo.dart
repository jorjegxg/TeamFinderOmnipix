import 'package:dartz/dartz.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/features/project_pages/data/models/project_model.dart';
import 'package:team_finder_app/features/project_pages/data/models/technology_stack.dart';

abstract class ProjectRepo {
  Future<Either<Failure<String>, List<ProjectModel>>>
      getCurrentUserActiveProjects();
  Future<Either<Failure<String>, List<ProjectModel>>>
      getCurrentUserInActiveProjects();
  //create project
  Future<Either<Failure<String>, void>> createProject(
      {required ProjectModel newProject});

  //get list of suggestions for technologies
  Future<Either<Failure<String>, List<TechnologyStack>>>
      getTechnologySuggestions();

  //create technologie
  Future<Either<Failure<String>, String>> createTechnology(
      {required TechnologyStack newTechnology});
}
