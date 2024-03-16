part of 'projects_bloc.dart';

abstract class ProjectsState extends Equatable {
  const ProjectsState();

  @override
  List<Object> get props => [];
}

class ProjectInitial extends ProjectsState {}

class ProjectsLoaded extends ProjectsState {
  final List<ProjectEntity>? activeProjects;
  final List<ProjectEntity>? inactiveProjects;
  final StatusOfProject switchState;

  const ProjectsLoaded({
    required this.switchState,
    this.activeProjects,
    this.inactiveProjects,
  });

  @override
  List<Object> get props => [activeProjects!, inactiveProjects!, switchState];
}

class ProjectsError extends ProjectsState {
  final String message;

  const ProjectsError(this.message);

  @override
  List<Object> get props => [message];
}

class ProjectsLoading extends ProjectsState {}

class ProjectsEmpty extends ProjectsState {}
