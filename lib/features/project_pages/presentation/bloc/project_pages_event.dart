part of 'project_pages_bloc.dart';

abstract class ProjectPagesEvent extends Equatable {
  const ProjectPagesEvent();

  @override
  List<Object> get props => [];
}

//o sa iau o lista de project entities
class GetProjectPages extends ProjectPagesEvent {
  final List<ProjectEntity> projects;

  const GetProjectPages(this.projects);

  @override
  List<Object> get props => [projects];
}
