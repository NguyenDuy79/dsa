import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'action_event.dart';
part 'action_state.dart';

class ActionBloc extends Bloc<ActionEvent, ActionState> {
  ActionBloc() : super(ActionInitial()) {
    on<ChooseExerciseMethod>(_chooseExerciseMethod);
    on<ChooseMuscleGroupSelection>(_addMuscleGroup);
    on<UnChooseMuscleGroupSelection>(_removeMuscleGroup);
    on<ChooseExercise>(_addExercise);
    on<UnChooseExercise>(_removeExercise);
    on<ChooseSet>(_addSet);
    on<ChooseRestTime>(_addRestTime);
  }
  void _chooseExerciseMethod(
      ChooseExerciseMethod event, Emitter<ActionState> emit) {
    emit(state.copyWith(method: event.method));
  }

  void _addMuscleGroup(
      ChooseMuscleGroupSelection event, Emitter<ActionState> emit) {
    emit(state.copyWith(
        muscleGroup: '${state.muscleGroup}${event.muscleGroup},'));
  }

  void _removeMuscleGroup(
      UnChooseMuscleGroupSelection event, Emitter<ActionState> emit) {
    emit(state.copyWith(
        muscleGroup:
            state.muscleGroup.replaceAll('${event.muscleGroup},', '')));
  }

  void _addExercise(ChooseExercise event, Emitter<ActionState> emit) {
    emit(state.copyWith(exercise: '${state.exercise}${event.exercise},'));
  }

  void _removeExercise(UnChooseExercise event, Emitter<ActionState> emit) {
    emit(state.copyWith(
        exercise: state.exercise.replaceAll('${event.exercise},', '')));
  }

  void _addSet(ChooseSet event, Emitter<ActionState> emit) {
    String set = '';
    if (state.set == '') {
      for (int i = 0; i < event.lenght; i++) {
        if (i == event.index) {
          set = '$set${event.value},';
        } else {
          set = '$set,';
        }
      }
    } else {
      for (int i = 0; i < event.lenght; i++) {
        if (i == event.index) {
          set = '$set${event.value},';
        } else if (i == event.lenght) {
          set = '$set${state.set.split(',')[i]}';
        } else {
          set = '$set${state.set.split(',')[i]},';
        }
      }
    }

    emit(state.copyWith(set: set));
  }

  void _addRestTime(ChooseRestTime event, Emitter<ActionState> emit) {
    String restTime = '';
    if (state.restTime == '') {
      for (int i = 0; i < event.lenght; i++) {
        if (i == event.index) {
          restTime = '$restTime${event.value},';
        } else {
          restTime = '$restTime,';
        }
      }
    } else {
      for (int i = 0; i < event.lenght; i++) {
        if (i == event.index) {
          restTime = '$restTime${event.value},';
        } else if (i == event.lenght) {
          restTime = '$restTime${state.restTime.split(',')[i]}';
        } else {
          restTime = '$restTime${state.restTime.split(',')[i]},';
        }
      }
    }

    emit(state.copyWith(restTime: restTime));
  }
}
