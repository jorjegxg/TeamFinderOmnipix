part of 'projects_bloc.dart';

abstract class ProjectsEvent extends Equatable {
  const ProjectsEvent();

  @override
  List<Object> get props => [];
}

//o sa iau o lista de project entities
class GetProjectPages extends ProjectsEvent {
  final List<ProjectEntity> projects;

  const GetProjectPages(this.projects);

  @override
  List<Object> get props => [projects];
}
