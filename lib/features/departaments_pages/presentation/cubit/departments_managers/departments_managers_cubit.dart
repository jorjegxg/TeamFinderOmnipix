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
  ) : super(const DepartmentsManagersState(
          managers: [],
          isLoading: false,
        ));

  Future<void> getDepartmentManagers() async {
    emit(state.copyWith(isLoading: true));
    final result = await departmentUseCase.getDepartmentManagers();
    result.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          isLoading: false,
        ),
      ),
      (r) => emit(
        state.copyWith(
          managers: r,
          isLoading: false,
        ),
      ),
    );
  }

  void selectManager(Manager manager) {
    emit(
      state.copyWith(
        selectedManager: manager,
      ),
    );
  }
}
