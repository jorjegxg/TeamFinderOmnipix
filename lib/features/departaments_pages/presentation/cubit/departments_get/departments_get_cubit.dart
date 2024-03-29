import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/department_summary.dart';
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart';

part 'departments_get_state.dart';

@singleton
class DepartmentsGetCubit extends Cubit<DepartmentsGetState> {
  final DepartmentUseCase departmentUseCase;

  DepartmentsGetCubit(
    this.departmentUseCase,
  ) : super(DepartmentsGetInitial());

  void getDepartmentsFromOrganization(bool isAdmin) async {
    emit(DepartmentsGetManagersLoading());
    if (isAdmin) {
      (await departmentUseCase.getDepartmentsFromOrganization()).fold(
        (l) => emit(DepartmentsGetManagersFailure(l.message)),
        (r) => emit(DepartmentsGetManagersSuccess(r)),
      );
    } else {
      (await departmentUseCase.getDepartmentOwned()).fold(
        (l) => emit(DepartmentsGetManagersFailure(l.message)),
        (r) => emit(DepartmentsGetManagersSuccess(r)),
      );
    }
  }

  void clearAllData() {
    emit(DepartmentsGetInitial());
  }
}
