import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'visibility_event.dart';
part 'visibility_state.dart';

class VisibilityBloc extends Bloc<VisibilityEvent, VisibilityState> {
  VisibilityBloc() : super(const VisibilityInitial(0, 0, 0, '')) {
    on<RestTimeEvent>(_restime);
    on<PracticeEvent>(_practice);
    on<VisibilityAdd>(_visibilityAdd);
  }
  void _restime(RestTimeEvent event, Emitter<VisibilityState> emit) {
    emit(RestTimeState(state.exercise, state.set, state.setDrop, ''));
  }

  void _visibilityAdd(VisibilityAdd event, Emitter<VisibilityState> emit) {
    if (event.exercise == '') {
      emit(RestTimeState(state.exercise, state.set, state.setDrop, ''));
    } else {
      if (state.exerciseName.contains(event.exercise)) {
        emit(RestTimeState(state.exercise, state.set, state.setDrop, ''));
      } else {
        emit(RestTimeState(
            state.exercise, state.set, state.setDrop, event.exercise));
      }
    }
  }

  void _practice(PracticeEvent event, Emitter<VisibilityState> emit) {
    if (!event.exerciseName.contains('Dropset')) {
      if (state.set == event.set) {
        if (state.exercise + 1 == event.exercise) {
          emit(DoneState(event.exercise, event.set, 0, ''));
        } else {
          if (event.nextExerciseName.contains('Dropset')) {
            emit(PracticeState(state.exercise + 1, 1, 1, ''));
          } else {
            emit(PracticeState(state.exercise + 1, 1, 0, ''));
          }
        }
      } else {
        emit(PracticeState(state.exercise, state.set + 1, 0, ''));
      }
    } else {
      if (state.setDrop == event.setDrop) {
        if (state.set == event.set) {
          if (state.exercise + 1 == event.exercise) {
            emit(DoneState(event.exercise, event.set, 0, ''));
          } else {
            if (event.nextExerciseName.contains('Dropset')) {
              emit(PracticeState(state.exercise + 1, 1, 1, ''));
            } else {
              emit(PracticeState(state.exercise + 1, 1, 0, ''));
            }
          }
        } else {
          emit(PracticeState(state.exercise, state.set + 1, 1, ''));
        }
      } else {
        if (state.set == 0) {
          emit(PracticeState(state.exercise, 1, state.setDrop + 1, ''));
        } else {
          emit(PracticeState(state.exercise, state.set, state.setDrop + 1, ''));
        }
      }
    }
  }
}
