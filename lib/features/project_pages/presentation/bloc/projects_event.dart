part of 'projects_bloc.dart';

abstract class ProjectsEvent extends Equatable {
  const ProjectsEvent();

  @override
  List<Object> get props => [];
}

//o sa iau o lista de project entities
class GetActiveProjectPages extends ProjectsEvent {
  // final List<ProjectEntity> projects;

  const GetActiveProjectPages();

  @override
  List<Object> get props => [];
}

class GetInActiveProjectPages extends ProjectsEvent {
  // final List<ProjectEntity> projects;

  const GetInActiveProjectPages();

  @override
  List<Object> get props => [];
}

class SwitchProjectPages extends ProjectsEvent {
  final StatusOfProject switchState;

  const SwitchProjectPages(this.switchState);

  @override
  List<Object> get props => [switchState];
}
