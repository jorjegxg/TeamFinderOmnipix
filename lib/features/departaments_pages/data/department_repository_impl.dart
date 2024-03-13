import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/features/auth/data/models/manager.dart';

@injectable
class DepartmentRepositoryImpl {
  Future<Either<Failure<String>, void>> createDepartment({
    required String name,
  }) async {
    var box = await Hive.openBox<String>(HiveConstants.authBox);
    String organizationId = box.get(HiveConstants.organizationId)!;

    return (ApiService().dioPost(
      url: "${EndpointConstants.baseUrl}/departament/create",
      data: {
        "name": name,
        "organizationId": organizationId,
      },
    ));
  }

  Future<Either<Failure<String>, List<Manager>>> getDepartmentManagers() async {
    var box = await Hive.openBox<String>(HiveConstants.authBox);
    String organizationId = box.get(HiveConstants.organizationId)!;

    return (await ApiService().dioGet(
      url:
          "${EndpointConstants.baseUrl}/departamentmanager/managersnodepartament/$organizationId",
    ))
        .fold(
      (l) => left(l),
      (r) => right(
        (r as List).map((e) => Manager.fromJson(e)).toList(growable: false),
      ),
    );
  }
}
