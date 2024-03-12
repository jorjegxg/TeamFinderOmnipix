import 'package:team_finder_app/features/project_pages/data/models/project_model.dart';
import 'package:team_finder_app/features/project_pages/domain/repositories/project_repo.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';

class ProjectRepoImpl extends ProjectRepo {
  @override
  Future<Either<Failure<String>, List<ProjectModel>>>
      getCurrentUserProjects() async {
    return (await ApiService().dioGet(
      //TODO George Luta : vezi daca endpoint-ul este bun
      url: "${EndpointConstants.baseUrl}/projects",
    ))
        .fold(
      (l) => Left(l),
      (r) {
        final List<ProjectModel> projects = [];
        //TODO George Luta : vezi daca e bine : ['projects']
        for (var project in r['projects']) {
          projects.add(ProjectModel.fromJson(project));
        }
        return Right(projects);
      },
    );
  }
}
