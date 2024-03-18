part of 'projects_bloc.dart';

class ProjectsState extends Equatable {
  final List<ProjectEntity> activeProjects;
  final List<ProjectEntity> inactiveProjects;
  final StatusOfProject switchState;
  final String errorMessage;
  final bool isLoading;

  const ProjectsState({
    required this.errorMessage,
    required this.switchState,
    required this.activeProjects,
    required this.inactiveProjects,
    required this.isLoading,
  });

  @override
  List<Object> get props => [activeProjects, inactiveProjects, switchState];

  //copy with
  ProjectsState copyWith({
    List<ProjectEntity>? activeProjects,
    List<ProjectEntity>? inactiveProjects,
    StatusOfProject? switchState,
    String? errorMessage,
    bool? isLoading,
  }) {
    return ProjectsState(
      activeProjects: activeProjects ?? this.activeProjects,
      inactiveProjects: inactiveProjects ?? this.inactiveProjects,
      switchState: switchState ?? this.switchState,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  //initital state
  factory ProjectsState.initial() {
    return ProjectsState(
      activeProjects: [],
      inactiveProjects: [],
      switchState: StatusOfProject.active,
      errorMessage: '',
      isLoading: false,
    );
  }
}
