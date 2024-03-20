import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_get/departments_get_cubit.dart';

@injectable
class DeleteDepartmentProvider extends ChangeNotifier {
  final DepartmentUseCase departmentUseCase;
  final DepartmentsGetCubit departmentsGetCubit;

  DeleteDepartmentProvider(this.departmentsGetCubit, this.departmentUseCase);

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> deleteDepartment(String departamentId) async {
    _isLoading = true;

    final result = await departmentUseCase.deleteDepartment(departamentId);

    result.fold(
      (l) {
        _errorMessage = l.message;
        _isLoading = false;
        notifyListeners();
      },
      (r) {
        departmentsGetCubit.getDepartmentsFromOrganization();
        _errorMessage = null;
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
