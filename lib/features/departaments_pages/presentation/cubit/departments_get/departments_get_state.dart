part of 'departments_get_cubit.dart';

sealed class DepartmentsGetState extends Equatable {
  const DepartmentsGetState();

  @override
  List<Object> get props => [];
}

final class DepartmentsGetInitial extends DepartmentsGetState {}

final class DepartmentsGetManagersLoading extends DepartmentsGetState {}

final class DepartmentsGetManagersSuccess extends DepartmentsGetState {
  final List<DepartmentSummary> departments;

  const DepartmentsGetManagersSuccess(this.departments);

  @override
  List<Object> get props => [departments];
}

final class DepartmentsGetManagersFailure extends DepartmentsGetState {
  final String errorMessage;

  const DepartmentsGetManagersFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
