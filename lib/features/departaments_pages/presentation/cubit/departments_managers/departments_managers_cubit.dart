import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/auth/data/models/manager.dart';
import 'package:team_finder_app/features/departaments_pages/domain/department_use_case.dart';

part 'departments_managers_state.dart';

@injectable
class DepartmentsManagersCubit extends Cubit<DepartmentsManagersState> {
  final DepartmentUseCase departmentUseCase;
  DepartmentsManagersCubit(
    this.departmentUseCase,
  ) : super(
          const DepartmentsManagersInitial(),
        );

  Future<void> getDepartmentManagers() async {
    emit(const DepartmentsManagersInitial());
    final result = await departmentUseCase.getDepartmentManagers();
    result.fold(
      (l) => emit(
        DepartmentsManagersError(
          errorMessage: l.message,
        ),
      ),
      (r) => emit(
        DepartmentsManagersLoaded(r),
      ),
    );
  }
}
