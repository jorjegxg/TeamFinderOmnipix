import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/auth/data/models/manager.dart';
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart';

part 'departments_state.dart';

@injectable
class DepartmentsCubit extends Cubit<DepartmentsState> {
  final DepartmentUseCase departmentUseCase;
  DepartmentsCubit(
    this.departmentUseCase,
  ) : super(DepartmentsInitial());

  void createDepartment({
    required String name,
    required String managerId,
  }) async {
    emit(DepartmentsCreateLoading());

    departmentUseCase.createDepartment(
      name: name,
      managerId: managerId,
    );

    emit(DepartmentsCreateSuccess());
  }
}
