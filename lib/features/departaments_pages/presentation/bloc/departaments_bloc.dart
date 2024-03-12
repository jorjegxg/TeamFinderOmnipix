import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'departaments_event.dart';
part 'departaments_state.dart';

class DepartamentsBloc extends Bloc<DepartamentsEvent, DepartamentsState> {
  DepartamentsBloc() : super(DepartamentsInitial()) {
    on<DepartamentsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
