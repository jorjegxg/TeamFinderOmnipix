import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/auth/data/models/manager.dart';
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_get/departments_get_cubit.dart';
import 'package:team_finder_app/injection.dart';

part 'department_create_state.dart';

@injectable
class DepartmentCreateCubit extends Cubit<DepartmentsState> {
  final DepartmentUseCase departmentUseCase;

  DepartmentCreateCubit(
    this.departmentUseCase,
  ) : super(DepartmentsInitial());

  void createDepartment({
    required String name,
    Manager? manager,
  }) async {
    emit(DepartmentsCreateLoading());

    (await departmentUseCase.createDepartment(
      name: name,
      managerId: manager,
    ))
        .fold((l) => emit(DepartmentsCreateFailure(l.message)), (r) {
      emit(DepartmentsCreateSuccess());
      getIt<DepartmentsGetCubit>().getDepartmentsFromOrganization(true);
    });
  }

  void clearAllData() {
    emit(DepartmentsInitial());
  }
}
