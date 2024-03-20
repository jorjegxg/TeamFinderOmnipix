import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/features/auth/data/models/manager.dart';
import 'package:team_finder_app/features/departaments_pages/data/department_repository_impl.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/alocation.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/dealocation.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/department_summary.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/validation.dart';
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

  Future<Either<Failure<String>, void>> createSkill(
      {required Skill skill}) async {
    return await departmentRepository.createSkill(skill: skill);
  }

//assign skill to departament
  Future<Either<Failure<String>, void>> assignSkillToDepartament(
      {required String skillId, required String departamentId}) async {
    return departmentRepository.assignSkillToDepartament(
      skillId: skillId,
      departamentId: departamentId,
    );
  }

  //get skills for departament

  Future<Either<Failure<String>, List<Skill>>> getSkillsForDepartament(
      String departamentId) async {
    return departmentRepository.getSkillsForDepartament(departamentId);
  }

  //statistics
  Future<Either<Failure<String>, Map<String, int>>> getStatisticsForDepartament(
      String departamentId, String skillId) async {
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
      String employeeId) async {
    return departmentRepository.removeEmployeeFromDepartment(
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

  //getSkillsNotInDepartament
  Future<Either<Failure<String>, List<Skill>>> getSkillsNotInDepartament(
      String departamentId) async {
    return departmentRepository.getSkillsNotInDepartament(departamentId);
  }

  //allocation/dealocation
  Future<Either<Failure<String>, List<Alocation>>> getAlocations(
      String departamentId) async {
    return departmentRepository.getAlocations(departamentId);
  }

  Future<Either<Failure<String>, List<Dealocation>>> getDealocations(
      String departamentId) async {
    return departmentRepository.getDealocations(departamentId);
  }

  //fetchAlocatoins
  Future<Either<Failure<String>, List<Validation>>> fetchValidation(
      String departamentId) async {
    return departmentRepository.fetchValidation(departamentId);
  }

  //accept/refuze

  Future<Either<Failure<String>, void>> acceptValidation(String validationId) {
    return departmentRepository.acceptValidation(validationId);
  }

  Future<Either<Failure<String>, void>> refuseValidation(String validationId) {
    return departmentRepository.refuseValidation(validationId);
  }

  // assignSkillDirectly(Employee employee) {}
  Future<Either<Failure<String>, void>> assignSkillDirectly(Employee employee,
      String departamentId, String skillId, int experience, int level) async {
    return departmentRepository.assignSkillDirectly(
        employee, departamentId, skillId, experience, level);
  }

  //get Categories
  Future<Either<Failure<String>, List<String>>> getCategories() async {
    return departmentRepository.getCategories();
  }

  // refuseAlocation(String id) {}

  // acceptAlocation(String id) {}

  // refuseDealocation(String id) {}

  // acceptDealocation(String id) {}

  Future<Either<Failure<String>, void>> refuseDealocation(String id) async {
    return departmentRepository.refuseDealocation(id);
  }

  Future<Either<Failure<String>, void>> acceptDealocation(String id) async {
    return departmentRepository.acceptDealocation(id);
  }

  Future<Either<Failure<String>, void>> refuseAlocation(String id) async {
    return departmentRepository.refuseAlocation(id);
  }

  Future<Either<Failure<String>, void>> acceptAlocation(String id) async {
    return departmentRepository.acceptAlocation(id);
  }

  Future<Either<Failure<String>, void>> deleteDepartment(
      String departamentId) async {
    return departmentRepository.deleteDepartment(departamentId);
  }
}
