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

  ProjectsBloc(this.projectsUsecase) : super(ProjectsState.initial()) {
    on<GetActiveProjectPages>(_onGetActiveProjectPages);
    on<GetInActiveProjectPages>(_onGetInActiveProjectPages);
    on<SwitchProjectPages>(_onSwitchProjectPages);
  }

  Future<void> _onGetActiveProjectPages(
      GetActiveProjectPages event, Emitter<ProjectsState> emit) async {
    emit(state.copyWith(isLoading: true));
    (await projectsUsecase.getCurrentUserActiveProjects()).fold(
      (l) => emit(state.copyWith(errorMessage: l.message, isLoading: false)),
      (r) => r.isEmpty
          ? emit(state.copyWith(
              activeProjects: [],
              isLoading: false,
              switchState: StatusOfProject.active,
            ))
          : emit(state.copyWith(
              activeProjects: r,
              isLoading: false,
              switchState: StatusOfProject.active,
            )),
    );
  }

  Future<void> _onGetInActiveProjectPages(
      GetInActiveProjectPages event, Emitter<ProjectsState> emit) async {
    emit(state.copyWith(isLoading: true));
    (await projectsUsecase.getCurrentUserInActiveProjects()).fold(
      (l) => emit(state.copyWith(errorMessage: l.message, isLoading: false)),
      (r) => r.isEmpty
          ? emit(state.copyWith(
              inactiveProjects: [],
              isLoading: false,
              switchState: StatusOfProject.past,
            ))
          : emit(state.copyWith(
              inactiveProjects: r,
              isLoading: false,
              switchState: StatusOfProject.past,
            )),
    );
  }

  Future<void> _onSwitchProjectPages(
      SwitchProjectPages event, Emitter<ProjectsState> emit) async {
    emit(state.copyWith(isLoading: true));
    if (event.switchState == StatusOfProject.active) {
      (await projectsUsecase.getCurrentUserActiveProjects()).fold(
        (l) => emit(
          state.copyWith(
            errorMessage: l.message,
            isLoading: false,
          ),
        ),
        (r) => r.isEmpty
            ? emit(
                state.copyWith(
                  activeProjects: [],
                  isLoading: false,
                  switchState: StatusOfProject.active,
                ),
              )
            : emit(
                state.copyWith(
                  activeProjects: r,
                  isLoading: false,
                  switchState: StatusOfProject.active,
                ),
              ),
      );
    } else {
      (await projectsUsecase.getCurrentUserInActiveProjects()).fold(
        (l) => emit(
          state.copyWith(
            errorMessage: l.message,
            isLoading: false,
          ),
        ),
        (r) => r.isEmpty
            ? emit(
                state.copyWith(
                  inactiveProjects: [],
                  isLoading: false,
                  switchState: StatusOfProject.past,
                ),
              )
            : emit(
                state.copyWith(
                  inactiveProjects: r,
                  isLoading: false,
                  switchState: StatusOfProject.past,
                ),
              ),
      );
    }
  }
}
