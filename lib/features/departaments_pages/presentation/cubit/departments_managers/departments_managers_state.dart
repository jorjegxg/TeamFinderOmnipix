part of 'departments_managers_cubit.dart';

sealed class DepartmentsManagersState extends Equatable {
  final List<Manager> managers;
  final String? errorMessage;
  final bool isLoading;
  final Manager? selectedManager;

  const DepartmentsManagersState({
    required this.managers,
    this.errorMessage,
    required this.isLoading,
    this.selectedManager,
  });

  @override
  List<Object?> get props => [managers, errorMessage, isLoading];
}

class DepartmentsManagersInitial extends DepartmentsManagersState {
  const DepartmentsManagersInitial()
      : super(managers: const [], isLoading: false);
}

class DepartmentsManagersLoading extends DepartmentsManagersState {
  const DepartmentsManagersLoading()
      : super(managers: const [], isLoading: true);
}

class DepartmentsManagersLoaded extends DepartmentsManagersState {
  const DepartmentsManagersLoaded(List<Manager> managers)
      : super(managers: managers, isLoading: false);
}

class DepartmentsManagersError extends DepartmentsManagersState {
  const DepartmentsManagersError({required String errorMessage})
      : super(managers: const [], errorMessage: errorMessage, isLoading: false);
}

class DepartmentsManagerSelectedChanged extends DepartmentsManagersState {
  const DepartmentsManagerSelectedChanged(
      Manager selectedManager, List<Manager> managers)
      : super(
          managers: managers,
          isLoading: false,
          selectedManager: selectedManager,
        );
}
