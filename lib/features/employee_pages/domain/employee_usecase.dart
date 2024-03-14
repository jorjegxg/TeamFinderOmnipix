import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/features/employee_pages/data/employee_repo_impl.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';

@injectable
class EmployeeUsecase {
  final EmployeeRepoImpl employeeRepoImpl;

  EmployeeUsecase(this.employeeRepoImpl);

  Future<String> getOrganizationId() {
    return employeeRepoImpl.getOrganizationId();
  }

  Future<void> copyLink(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  Future<Either<Failure, List<Employee>>> getEmployees() {
    return employeeRepoImpl.getEmployees();
  }
}
