part of 'projects_bloc.dart';

abstract class ProjectsState extends Equatable {
  const ProjectsState();

  @override
  List<Object> get props => [];
}

class ProjectInitial extends ProjectsState {}

class ProjectsLoaded extends ProjectsState {
  final List<ProjectEntity> projects;

  const ProjectsLoaded(this.projects);

  @override
  List<Object> get props => [projects];
}

class ProjectsError extends ProjectsState {
  final String message;

  const ProjectsError(this.message);

  @override
  List<Object> get props => [message];
}

class ProjectsLoading extends ProjectsState {}

class ProjectsEmpty extends ProjectsState {}
