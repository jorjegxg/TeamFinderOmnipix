part of 'departments_managers_cubit.dart';

class DepartmentsManagersState extends Equatable {
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

  //copy with
  DepartmentsManagersState copyWith({
    List<Manager>? managers,
    String? errorMessage,
    bool? isLoading,
    Manager? selectedManager,
  }) {
    return DepartmentsManagersState(
      managers: managers ?? this.managers,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      selectedManager: selectedManager ?? this.selectedManager,
    );
  }
}
