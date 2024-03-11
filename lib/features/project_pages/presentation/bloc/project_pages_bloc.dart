import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'project_pages_event.dart';
part 'project_pages_state.dart';

class ProjectPagesBloc extends Bloc<ProjectPagesEvent, ProjectPagesState> {
  ProjectPagesBloc() : super(ProjectPagesInitial()) {
    on<ProjectPagesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
