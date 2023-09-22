import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'action_event.dart';
part 'action_state.dart';

class ActionBloc extends Bloc<ActionEvent, ActionState> {
  int index = 0;
  ActionBloc() : super(ActionInitial()) {
    on<ChooseExerciseMethod>(_chooseExerciseMethod);
    on<ChooseMuscleGroupSelection>(_addMuscleGroup);
    on<UnChooseMuscleGroupSelection>(_removeMuscleGroup);
    on<ChooseExercise>(_addExercise);
    on<UnChooseExercise>(_removeExercise);
    on<ChooseSet>(_addSet);
    on<ChooseRestTime>(_addRestTime);
    on<SetExercise>(_setExercise);
    on<AddTemporaryDropSet>(_addTemporaryDropSet);
    on<AddTemporarySuperSet>(_addTemporarySuperSet);
    on<UpdateDropSet>(_updateDropSet);
    on<UpdateSuperSet>(_updateSuperSet);
    on<IndexPage>(_changeIndex);
    on<ChooseSetDrop>(_addSetDrop);
    on<ChooseRestTimeDrop>(_addRestDrop);
  }
  void _changeIndex(IndexPage event, Emitter<ActionState> emit) {
    index = event.index;
  }

  void _updateSuperSet(UpdateSuperSet event, Emitter<ActionState> emit) {
    List<int> newList = [];
    for (int i = 0; i < state.temporarySuperset.split(';').length - 1; i++) {
      newList.add(state.exercise.split(',').indexWhere(
            (element) => element == state.temporarySuperset.split(';')[i],
          ));
    }

    int temp = newList[0];
    for (int i = 0; i < newList.length - 1; i++) {
      for (int j = i + 1; j < newList.length; j++) {
        if (newList[i] > newList[j]) {
          temp = newList[j];

          newList[j] = newList[i];

          newList[i] = temp;
        }
      }
    }
    var newExercise = state.exercise;
    for (int i = 0; i < newList.length; i++) {
      if (i == 0) {
        newExercise = newExercise.replaceAll(
            '${state.exercise.split(',')[newList[0]]},',
            'Superset:${state.temporarySuperset},');
      } else {
        newExercise = newExercise.replaceAll(
            '${state.exercise.split(',')[newList[i]]},', '');
      }
    }

    emit(state.copyWith(exercise: newExercise, temporarySuperset: ''));
  }

  void _updateDropSet(UpdateDropSet event, Emitter<ActionState> emit) {
    emit(state.copyWith(
        exercise: state.exercise.replaceAll(
            state.temporaryDropset, 'Dropset:${state.temporaryDropset}'),
        temporaryDropset: ''));
  }

  void _addTemporarySuperSet(
      AddTemporarySuperSet event, Emitter<ActionState> emit) {
    if (state.temporarySuperset.contains(event.exercise)) {
      emit(state.copyWith(
          temporarySuperset:
              state.temporarySuperset.replaceAll('${event.exercise};', '')));
    } else {
      emit(state.copyWith(
          temporarySuperset: '${state.temporarySuperset}${event.exercise};'));
    }
  }

  void _addTemporaryDropSet(
      AddTemporaryDropSet event, Emitter<ActionState> emit) {
    if (state.temporaryDropset.contains(event.exercise)) {
      emit(state.copyWith(temporaryDropset: ''));
    } else {
      emit(state.copyWith(temporaryDropset: event.exercise));
    }
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

  void _setExercise(SetExercise event, Emitter<ActionState> emit) {
    emit(state.copyWith(exercise: event.exercise));
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
          if (event.exercise.contains('Dropset')) {
            if (state.set.split(',')[i].contains(':')) {
              set =
                  '$set${event.value}:${state.set.split(',')[i].split(':')[1]},';
            } else {
              set = '$set${event.value},';
            }
          } else {
            set = '$set${event.value},';
          }
        } else if (i == event.lenght) {
          set = '$set${state.set.split(',')[i]}';
        } else {
          set = '$set${state.set.split(',')[i]},';
        }
      }
    }

    emit(state.copyWith(set: set));
  }

  void _addRestDrop(ChooseRestTimeDrop event, Emitter<ActionState> emit) {
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
          if (event.exercise.contains('Dropset')) {
            if (state.restTime.split(',')[i].contains(':')) {
              restTime =
                  '$restTime${state.restTime.split(',')[i].split(':')[0]}:${event.value},';
            } else {
              restTime =
                  '$restTime${state.restTime.split(',')[i]}:${event.value},';
            }
          } else {
            restTime = '$restTime${event.value},';
          }
        } else if (i == event.lenght) {
          restTime = '$restTime${state.restTime.split(',')[i]}';
        } else {
          restTime = '$restTime${state.restTime.split(',')[i]},';
        }
      }
    }

    emit(state.copyWith(restTime: restTime));
  }

  void _addSetDrop(ChooseSetDrop event, Emitter<ActionState> emit) {
    String set = '';
    if (state.set == '') {
      for (int i = 0; i < event.lenght; i++) {
        if (i == event.index) {
          set = '$set:${event.value},';
        } else {
          set = '$set,';
        }
      }
    } else {
      for (int i = 0; i < event.lenght; i++) {
        if (i == event.index) {
          if (event.exercise.contains('Dropset')) {
            if (state.set.split(',')[i].contains(':')) {
              set =
                  '$set${state.set.split(',')[i].split(':')[0]}:${event.value},';
            } else {
              set = '$set${state.set.split(',')[i]}:${event.value},';
            }
          } else {
            set = '$set${event.value},';
          }
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
          if (event.exercise.contains('Dropset')) {
            if (state.restTime.split(',')[i].contains(':')) {
              restTime =
                  '$restTime${event.value}:${state.restTime.split(',')[i].split(':')[1]},';
            } else {
              restTime = '$restTime${event.value},';
            }
          } else {
            restTime = '$restTime${event.value},';
          }
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
