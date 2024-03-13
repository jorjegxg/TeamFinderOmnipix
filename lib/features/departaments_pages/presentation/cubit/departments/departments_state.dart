part of 'departments_cubit.dart';

sealed class DepartmentsState extends Equatable {
  const DepartmentsState();

  @override
  List<Object> get props => [];
}

final class DepartmentsInitial extends DepartmentsState {}

final class DepartmentsCreateLoading extends DepartmentsState {}

final class DepartmentsCreateSuccess extends DepartmentsState {}
