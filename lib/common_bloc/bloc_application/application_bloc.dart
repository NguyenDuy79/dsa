import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app_bloc/common_app/application.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(ApplicationInitial()) {
    on<SetupApplication>(_setupApplication);
  }
  _setupApplication(
      SetupApplication event, Emitter<ApplicationState> emit) async {
    await Application.setPreferences();
    emit(ApplicationCompleted());
  }
}
