import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';
import 'package:team_finder_app/features/project_pages/domain/usecases/projects_usecase.dart';

part 'project_pages_event.dart';
part 'project_pages_state.dart';

@injectable
class ProjectPagesBloc extends Bloc<ProjectPagesEvent, ProjectPagesState> {
  final ProjectsUsecase projectsUsecase;

  ProjectPagesBloc(this.projectsUsecase) : super(ProjectPagesInitial()) {
    on<GetProjectPages>(_onGetProjectPages);
  }

  Future<void> _onGetProjectPages(
      GetProjectPages event, Emitter<ProjectPagesState> emit) async {
    // emit(ProjectPagesLoaded(event.projects));
  }
}
