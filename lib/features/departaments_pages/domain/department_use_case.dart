import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/features/auth/data/models/manager.dart';
import 'package:team_finder_app/features/departaments_pages/data/department_repository_impl.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/department.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';
import 'package:team_finder_app/features/project_pages/data/models/project_model.dart';

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

  Future<Either<Failure<String>, List<Employee>>> getFreeEmployees() async {
    return departmentRepository.getFreeEmployees();
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

  //statistics
  Future<Either<Failure<String>, List<Map<String, int>>>>
      getStatisticsForDepartament(String departamentId, String skillId) async {
    return departmentRepository.getStatisticsForDepartament(
      departamentId,
      skillId,
    );
  }

  //get projects for departament
  Future<Either<Failure<String>, List<ProjectModel>>> getProjectsForDepartament(
      String departamentId) async {
    return departmentRepository.getProjectsForDepartament(departamentId);
  }

  //add employees to departament
  Future<Either<Failure<String>, void>> addEmployeesToDepartment({
    required String departmentId,
    required List<Employee> employees,
  }) async {
    return departmentRepository.addEmployeesToDepartment(
      departmentId: departmentId,
      employees: employees,
    );
  }

  //removeEmployeeFromDepartment
  Future<Either<Failure<String>, void>> removeEmployeeFromDepartment(
      String departamentId, String employeeId) async {
    return departmentRepository.removeEmployeeFromDepartment(
      departamentId,
      employeeId,
    );
  }

  //deleteSkillFromDepartament
  Future<Either<Failure<String>, void>> deleteSkillFromDepartament(
      String departamentId, String skillId) async {
    return departmentRepository.deleteSkillFromDepartament(
      departamentId,
      skillId,
    );
  }
}
