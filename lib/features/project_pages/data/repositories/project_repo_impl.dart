import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/util/logger.dart';
import 'package:team_finder_app/features/project_pages/data/models/project_model.dart';
import 'package:team_finder_app/features/project_pages/data/models/technology_stack.dart';
import 'package:team_finder_app/features/project_pages/domain/repositories/project_repo.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';

@LazySingleton(as: ProjectRepo)
class ProjectRepoImpl extends ProjectRepo {
  @override
  Future<Either<Failure<String>, List<ProjectModel>>>
      getCurrentUserActiveProjects() async {
    var box = Hive.box<String>(HiveConstants.authBox);
    String employeeId = box.get(HiveConstants.userId)!;
    return (await ApiService().dioGet(
      //TODO George Luta : vezi daca endpoint-ul este bun

      url:
          "${EndpointConstants.baseUrl}/project/projectdetailactive/$employeeId",
    ))
        .fold(
      (l) => Left(l),
      (r) {
        final List<ProjectModel> projects = [];
        //TODO George Luta : vezi daca e bine : ['projects']
        for (var project in r) {
          projects.add(ProjectModel.fromMap(project));
        }
        return Right(projects);
      },
    );
  }

  @override
  Future<Either<Failure<String>, List<ProjectModel>>>
      getCurrentUserInActiveProjects() async {
    var box = Hive.box<String>(HiveConstants.authBox);
    String employeeId = box.get(HiveConstants.userId)!;
    return (await ApiService().dioGet(
      //TODO George Luta : vezi daca endpoint-ul este bun

      url:
          "${EndpointConstants.baseUrl}/projects/projectdetailinactive/${employeeId}",
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

  @override
  Future<Either<Failure<String>, void>> createProject(
      {required ProjectModel newProject}) async {
    var box = Hive.box<String>(HiveConstants.authBox);
    String organizationId = box.get(HiveConstants.organizationId)!;
    String userId = box.get(HiveConstants.userId)!;
// {
//   "name": "string",
//   "period": "string",
//   "startDate": "2024-03-16T13:47:33.247Z",
//   "deadlineDate": "2024-03-16T13:47:33.247Z",
//   "description": "string",
//   "technologyStack": [
//     "string"
//   ],
//   "teamRoles": {},
//   "status": "string",
//   "organizationId": "string",
//   "employeeId": "string"
// }
    return (await ApiService().dioPost(
      url: "${EndpointConstants.baseUrl}/project",
      data: {
        "name": newProject.name,
        "period": newProject.period.toStringValue(),
        "startDate": newProject.startDate.toString(),
        "deadlineDate": newProject.deadlineDate.toString(),
        "description": newProject.description,
        "technologyStack": newProject.technologyStack.map((e) => e.id).toList(),
        "teamRoles": newProject.teamRoles,
        "status": newProject.status,
        "organizationId": organizationId,
        "employeeId": userId,
      },
    ))
        .fold(
      (l) {
        return Left(l);
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure<String>, List<TechnologyStack>>>
      getTechnologySuggestions() async {
    // TODO: implement getTechnologySuggestions
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure<String>, String>> createTechnology(
      {required TechnologyStack newTechnology}) async {
//      {
//   "name": "string",
//   "organizationId": "string"
// }
    var box = Hive.box<String>(HiveConstants.authBox);
    String organizationId = box.get(HiveConstants.organizationId)!;
    return (await ApiService().dioPost(
      url: "${EndpointConstants.baseUrl}/projectmanager/technologystack",
      data: {
        "name": newTechnology.name,
        "organizationId": organizationId,
      },
    ))
        .fold(
      (l) => Left(l),
      (r) => Right(r['id']),
    );
  }

  //get list of sugestoins
}
// {
//   "name": "string",
//   "period": "string",
//   "startDate": "2024-03-16T08:47:07.850Z",
//   "deadlineDate": "2024-03-16T08:47:07.850Z",
//   "description": "string",
//   "technologyStack": [
//     "string"
//   ],
//   "teamRoles": {},
//   "status": "string",
//   "organizationId": "string",
//   "employeeId": "string"
// }