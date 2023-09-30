import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'visibility_event.dart';
part 'visibility_state.dart';

class VisibilityBloc extends Bloc<VisibilityEvent, VisibilityState> {
  VisibilityBloc() : super(const VisibilityInitial(0, 0, 0, '')) {
    on<RestTimeEvent>(_restime);
    on<PracticeEvent>(_practice);
    on<VisibilityAdd>(_visibilityAdd);
    on<PracticeCardioEvent>(_practiceCardioEvent);
    on<DoneEvent>(_doneEvent);
  }
  void _doneEvent(DoneEvent event, Emitter<VisibilityState> emit) {
    emit(DoneState(
        state.exercise, state.set, state.setDrop, state.exerciseName));
  }

  void _practiceCardioEvent(
      PracticeCardioEvent event, Emitter<VisibilityState> emit) {
    if (event.level == 0) {
      if (state.exercise + 1 == event.exercise) {
        if (state.set == event.set) {
          emit(DoneState(event.exercise, event.set, 0, ''));
        } else {
          emit(PracticeCardioState(0, state.set + 1, 0, ''));
        }
      } else {
        if (state.set == 0) {
          emit(PracticeCardioState(state.exercise, state.set + 1, 0, ''));
        } else {
          emit(PracticeCardioState(state.exercise + 1, state.set, 0, ''));
        }
      }
    } else {
      if (state.exercise + 1 == event.exercise) {
        if (state.set == event.set) {
          if (state.setDrop == event.level) {
            emit(DoneState(event.exercise, event.set, event.level, ''));
          } else {
            emit(PracticeCardioState(0, 1, state.setDrop + 1, ''));
          }
        } else {
          emit(PracticeCardioState(0, state.set + 1, state.setDrop, ''));
        }
      } else {
        if (state.set == 0) {
          emit(PracticeCardioState(
              state.exercise, state.set + 1, state.setDrop + 1, ''));
        } else {
          emit(PracticeCardioState(
              state.exercise + 1, state.set, state.setDrop, ''));
        }
      }
    }
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
    if (event.exerciseName.contains(',')) {
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
            emit(PracticeState(
                state.exercise, state.set, state.setDrop + 1, ''));
          }
        }
      }
    } else {
      emit(const PracticeState(0, 0, 0, ''));
    }
  }
}
