import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';
import 'package:team_finder_app/features/project_pages/domain/usecases/projects_usecase.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_segmented_button.dart';

part 'projects_event.dart';
part 'projects_state.dart';

@injectable
class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final ProjectsUsecase projectsUsecase;

  ProjectsBloc(this.projectsUsecase) : super(ProjectInitial()) {
    on<GetActiveProjectPages>(_onGetActiveProjectPages);
    on<GetInActiveProjectPages>(_onGetInActiveProjectPages);
    on<SwitchProjectPages>(_onSwitchProjectPages);
  }

  Future<void> _onGetActiveProjectPages(
      GetActiveProjectPages event, Emitter<ProjectsState> emit) async {
    emit(ProjectsLoading());
    (await projectsUsecase.getCurrentUserActiveProjects()).fold(
      (l) => emit(ProjectsError(l.message)),
      (r) => r.isEmpty
          ? emit(ProjectsEmpty())
          : emit(
              ProjectsLoaded(
                activeProjects: r,
                switchState: StatusOfProject.active,
              ),
            ),
    );
  }

  Future<void> _onGetInActiveProjectPages(
      GetInActiveProjectPages event, Emitter<ProjectsState> emit) async {
    emit(ProjectsLoading());
    (await projectsUsecase.getCurrentUserInActiveProjects()).fold(
      (l) => emit(ProjectsError(l.message)),
      (r) => r.isEmpty
          ? emit(ProjectsEmpty())
          : emit(
              ProjectsLoaded(
                switchState: StatusOfProject.past,
                inactiveProjects: r,
              ),
            ),
    );
  }

  Future<void> _onSwitchProjectPages(
      SwitchProjectPages event, Emitter<ProjectsState> emit) async {
    emit(ProjectsLoading());
    if (state is ProjectsLoaded) {
      if ((state as ProjectsLoaded).activeProjects == null) {
        await _onGetActiveProjectPages(GetActiveProjectPages(), emit);
      }
      if ((state as ProjectsLoaded).inactiveProjects == null) {
        await _onGetInActiveProjectPages(GetInActiveProjectPages(), emit);
      }
    }
    emit(ProjectsLoaded(
      switchState: event.switchState,
    ));
  }
}
