import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/features/auth/data/models/manager.dart';
import 'package:team_finder_app/features/departaments_pages/data/department_repository_impl.dart';

@injectable
class DepartmentUseCase {
  final DepartmentRepositoryImpl departmentRepository;

  DepartmentUseCase(this.departmentRepository);

  Future<Either<Failure<String>, void>> createDepartment(
      {required String name, String? managerId}) async {
    //fa validarea aici

    if (name.isEmpty) {
      return left(FieldFailure(message: 'Name cannot be empty'));
    }

    departmentRepository.createDepartment(
      name: name,
    );

    //todo : daca departmentRepository.createDepartment fa assign si la manager (daca nu e null)

    return right(null);
  }

  Future<Either<Failure<String>, List<Manager>>> getDepartmentManagers() async {
    return departmentRepository.getDepartmentManagers();
  }
}
