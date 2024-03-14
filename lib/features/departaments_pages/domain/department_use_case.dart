import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/features/auth/data/models/manager.dart';
import 'package:team_finder_app/features/departaments_pages/data/department_repository_impl.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/department.dart';

@injectable
class DepartmentUseCase {
  final DepartmentRepositoryImpl departmentRepository;

  DepartmentUseCase(this.departmentRepository);

  Future<Either<Failure<String>, void>> createDepartment(
      {required String name, required String managerId}) async {
    //fa validarea aici

    if (name.isEmpty) {
      return left(FieldFailure(message: 'Name cannot be empty'));
    }

    return (await departmentRepository.createDepartment(
      name: name,
    ))
        .fold((l) => left(l), (r) async {
      return (await departmentRepository.assignManagerToDepartment(
        managerId: managerId,
        departmentId: r,
      ));
    });

    //todo : daca departmentRepository.createDepartment fa assign si la manager (daca nu e null)
  }

  Future<Either<Failure<String>, List<Manager>>> getDepartmentManagers() async {
    return departmentRepository.getDepartmentManagers();
  }

  Future<Either<Failure<String>, List<Department>>>
      getDepartmentsFromOrganization() async {
    return departmentRepository.getDepartmentsFromOrganization();
  }
}
