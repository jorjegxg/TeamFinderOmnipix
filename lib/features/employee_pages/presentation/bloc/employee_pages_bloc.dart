import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'employee_pages_event.dart';
part 'employee_pages_state.dart';

class EmployeePagesBloc extends Bloc<EmployeePagesEvent, EmployeePagesState> {
  EmployeePagesBloc() : super(EmployeePagesInitial()) {
    on<EmployeePagesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
