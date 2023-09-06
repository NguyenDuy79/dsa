import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'visibility_event.dart';
part 'visibility_state.dart';

class VisibilityBloc extends Bloc<VisibilityEvent, VisibilityState> {
  VisibilityBloc() : super(VisibilityInitial(0, 0)) {
    on<RestTimeEvent>(_restime);
    on<PracticeEvent>(_practice);
  }
  void _restime(RestTimeEvent event, Emitter<VisibilityState> emit) {
    emit(RestTimeState(state.exercise, state.set));
  }

  void _practice(PracticeEvent event, Emitter<VisibilityState> emit) {
    if (state.set == event.set) {
      if (state.exercise + 1 == event.exercise) {
        emit(DoneState(event.exercise, event.set));
      } else {
        emit(PracticeState(state.exercise + 1, state.set = 1));
      }
    } else {
      emit(PracticeState(state.exercise, state.set + 1));
    }
  }
}
