import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/features/auth/data/models/manager.dart';
import 'package:team_finder_app/features/departaments_pages/data/department_repository_impl.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/department.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';

@injectable
class DepartmentUseCase {
  final DepartmentRepositoryImpl departmentRepository;

  DepartmentUseCase(this.departmentRepository);

  Future<Either<Failure<String>, void>> createDepartment(
      {required String name, Manager? managerId}) async {
    //fa validarea aici

    if (name.isEmpty) {
      return left(FieldFailure(message: 'Name cannot be empty'));
    }

    if (managerId == null) {
      return left(FieldFailure(message: 'Manager cannot be empty'));
    }

    return (await departmentRepository.createDepartment(
      name: name,
    ))
        .fold((l) => left(l), (r) async {
      return (await departmentRepository.assignManagerToDepartment(
        managerId: managerId.id,
        departmentId: r,
      ));
    });

    //todo : daca departmentRepository.createDepartment fa assign si la manager (daca nu e null)
  }

  Future<Either<Failure<String>, List<Manager>>> getDepartmentManagers() async {
    return departmentRepository.getDepartmentManagers();
  }

  Future<Either<Failure<String>, List<DepartmentSummary>>>
      getDepartmentsFromOrganization() async {
    return departmentRepository.getDepartmentsFromOrganization();
  }

  Future<Either<Failure<String>, List<Employee>>> getDepartamentEmployees(
      String departamentId) async {
    return departmentRepository.getDepartamentEmployees(departamentId);
  }

  Future<Either<Failure<String>, void>> getFreeEmployees(
      {required String departamentId}) async {
    return departmentRepository.getFreeEmployees(
      departamentId: departamentId,
    );
  }

  Future<Either<Failure<String>, void>> createSkillAndAssign(
      {required Skill skill, required String departamentId}) async {
    final answer = await departmentRepository.createSkill(skill: skill);

    return answer.fold(
      (l) => left(l),
      (r) async {
        return (await departmentRepository.assignSkillToDepartament(
          skillId: r,
          departamentId: departamentId,
        ))
            .fold(
          (l) => left(l),
          (r) => right(r),
        );
      },
    );
  }

  //get skills for departament

  Future<Either<Failure<String>, List<Skill>>> getSkillsForDepartament(
      String departamentId) async {
    return departmentRepository.getSkillsForDepartament(departamentId);
  }
}
