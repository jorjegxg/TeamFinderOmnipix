import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';
import 'package:team_finder_app/features/project_pages/domain/usecases/projects_usecase.dart';

part 'projects_event.dart';
part 'projects_state.dart';

@injectable
class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final ProjectsUsecase projectsUsecase;

  ProjectsBloc(this.projectsUsecase) : super(ProjectInitial()) {
    on<GetProjectPages>(_onGetProjectPages);
  }

  Future<void> _onGetProjectPages(
      GetProjectPages event, Emitter<ProjectsState> emit) async {
    emit(ProjectsLoading());
    (await projectsUsecase.getCurrentUserProjects()).fold(
      (l) => emit(ProjectsError(l.message)),
      (r) => r.isEmpty
          ? emit(ProjectsEmpty())
          : emit(
              ProjectsLoaded(r),
            ),
    );
  }
}
