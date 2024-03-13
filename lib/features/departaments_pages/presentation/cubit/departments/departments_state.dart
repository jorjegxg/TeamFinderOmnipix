part of 'departments_cubit.dart';

sealed class DepartmentsState extends Equatable {
  const DepartmentsState();

  @override
  List<Object> get props => [];
}

final class DepartmentsInitial extends DepartmentsState {}

final class DepartmentsCreateLoading extends DepartmentsState {}

final class DepartmentsCreateSuccess extends DepartmentsState {}

final class DepartmentsCreateFailure extends DepartmentsState {
  final String errorMessage;

  const DepartmentsCreateFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
