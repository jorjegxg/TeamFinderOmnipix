import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/department.dart';
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart';

part 'departments_get_state.dart';

@injectable
class DepartmentsGetCubit extends Cubit<DepartmentsGetState> {
  final DepartmentUseCase departmentUseCase;

  DepartmentsGetCubit(
    this.departmentUseCase,
  ) : super(DepartmentsGetInitial());

  void getDepartmentsFromOrganization() async {
    emit(DepartmentsGetManagersLoading());

    (await departmentUseCase.getDepartmentsFromOrganization()).fold(
      (l) => emit(DepartmentsGetManagersFailure(l.message)),
      (r) => emit(DepartmentsGetManagersSuccess(r)),
    );
  }
}
