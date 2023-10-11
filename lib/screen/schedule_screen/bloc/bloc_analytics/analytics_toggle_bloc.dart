import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app_bloc/config/config.dart';
import 'package:fitness_app_bloc/db/database_analytics.dart';
import 'package:fitness_app_bloc/reused/reused.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

part 'analytics_toggle_event.dart';
part 'analytics_toggle_state.dart';

class AnalyticsToggleBloc
    extends Bloc<AnalyticsToggleEvent, AnalyticsToggleState> {
  AnalyticsToggleBloc() : super(AnalyticsToggleInitial()) {
    on<AddDayOff>(_addDayOff);
    on<ChooseMuscleGroupSelection>(_addMuscleGroup);
    on<UnChooseMuscleGroupSelection>(_removeMuscleGroup);
    on<ChooseExercise>(_addExercise);
    on<UnChooseExercise>(_removeExercise);
    on<UpdateCount>(_updateCount);
    on<ResetMuscleGroup>(_resetMuscleGroup);
    on<AddExerciseMethod>(_addExerciseMethod);
    on<SubmitWorkoutSchedule>(_submitWorkout);
    on<UpdateCountMethod>(_updateCountMethod);
    on<AddDayOffDay>(_addDayOffDay);
    on<ChangePage>(_changePage);
    on<AddCardioMethod>(_addCardioMethod);
    on<ChooseExerciseCardio>(_chooseExerciseCardio);
    on<AddLevel>(_addLevel);
    on<UpdateExericse>(_updateExercise);
    on<ChooseHiitMethod>(_chooseHiitMethod);
    on<UpdateCountLevel>(_updateCountLevel);
    on<ResetDataCardio>(_resetDataCardio);
  }
  void _resetDataCardio(
      ResetDataCardio event, Emitter<AnalyticsToggleState> emit) {
    emit(state.copyWith(
        caridoMethod: '',
        hiitMethod: '',
        countLevel: 0,
        level: '',
        chooseExerciseCardio: false));
  }

  void _updateCountLevel(
      UpdateCountLevel event, Emitter<AnalyticsToggleState> emit) {
    if (event.increase) {
      emit(state.copyWith(countLevel: state.countLevel + 1));
    } else {
      emit(state.copyWith(countLevel: state.countLevel - 1));
    }
  }

  void _chooseHiitMethod(
      ChooseHiitMethod event, Emitter<AnalyticsToggleState> emit) {
    emit(state.copyWith(hiitMethod: event.hiitMethod));
  }

  void _updateExercise(
      UpdateExericse event, Emitter<AnalyticsToggleState> emit) {
    switch (state.count) {
      case AppString.mon:
        emit(state.copyWith(mon: MethodReused.updateExercise(state)));
      case AppString.tue:
        emit(state.copyWith(tue: MethodReused.updateExercise(state)));
      case AppString.wed:
        emit(state.copyWith(wed: MethodReused.updateExercise(state)));
      case AppString.thu:
        emit(state.copyWith(thu: MethodReused.updateExercise(state)));
      case AppString.fri:
        emit(state.copyWith(fri: MethodReused.updateExercise(state)));
      case AppString.sat:
        emit(state.copyWith(sat: MethodReused.updateExercise(state)));
      default:
        emit(state.copyWith(sun: MethodReused.updateExercise(state)));
    }
  }

  void _addLevel(AddLevel event, Emitter<AnalyticsToggleState> emit) {
    emit(state.copyWith(level: event.level));
  }

  void _chooseExerciseCardio(
      ChooseExerciseCardio event, Emitter<AnalyticsToggleState> emit) {
    emit(state.copyWith(chooseExerciseCardio: event.value));
  }

  void _changePage(ChangePage event, Emitter<AnalyticsToggleState> emit) {
    emit(state.copyWith(index: event.index));
  }

  _addDayOffDay(AddDayOffDay event, Emitter<AnalyticsToggleState> emit) {
    switch (event.day) {
      case AppString.mon:
        emit(state.copyWith(mon: AppString.dayOff));
      case AppString.tue:
        emit(state.copyWith(tue: AppString.dayOff));
      case AppString.wed:
        emit(state.copyWith(wed: AppString.dayOff));
      case AppString.thu:
        emit(state.copyWith(thu: AppString.dayOff));
      case AppString.fri:
        emit(state.copyWith(fri: AppString.dayOff));
      case AppString.sat:
        emit(state.copyWith(sat: AppString.dayOff));

      default:
        emit(state.copyWith(sun: AppString.dayOff));
    }
  }

  _addDayOff(AddDayOff event, Emitter<AnalyticsToggleState> emit) {
    if (state.allDay.split(',').contains(event.day)) {
      if ((state.allDay.split(',').length - 1) > event.dayOffMin) {
        emit(state.copyWith(
            allDay: state.allDay.replaceAll('${event.day},', '')));
      }
    } else {
      emit(state.copyWith(allDay: '${state.allDay}${event.day},'));
    }
  }

  void _addMuscleGroup(
      ChooseMuscleGroupSelection event, Emitter<AnalyticsToggleState> emit) {
    emit(state.copyWith(
        muscleGroup: '${state.muscleGroup}${event.muscleGroup},'));
  }

  void _removeMuscleGroup(
      UnChooseMuscleGroupSelection event, Emitter<AnalyticsToggleState> emit) {
    emit(state.copyWith(
        muscleGroup:
            state.muscleGroup.replaceAll('${event.muscleGroup},', '')));
  }

  void _addExerciseMethod(
      AddExerciseMethod event, Emitter<AnalyticsToggleState> emit) {
    switch (event.day) {
      case AppString.mon:
        if (state.mon.contains(event.method)) {
          emit(state.copyWith(
              mon: state.mon.replaceAll('${event.method}:;', '')));
        } else {
          emit(state.copyWith(mon: '${state.mon}${event.method}:;'));
        }

      case AppString.tue:
        if (state.tue.contains(event.method)) {
          emit(state.copyWith(
              tue: state.tue.replaceAll('${event.method}:;', '')));
        } else {
          emit(state.copyWith(tue: '${state.tue}${event.method}:;'));
        }
      case AppString.wed:
        if (state.wed.contains(event.method)) {
          emit(state.copyWith(
              wed: state.wed.replaceAll('${event.method}:;', '')));
        } else {
          emit(state.copyWith(wed: '${state.wed}${event.method}:;'));
        }
      case AppString.thu:
        if (state.thu.contains(event.method)) {
          emit(state.copyWith(
              thu: state.thu.replaceAll('${event.method}:;', '')));
        } else {
          emit(state.copyWith(thu: '${state.thu}${event.method}:;'));
        }
      case AppString.fri:
        if (state.fri.contains(event.method)) {
          emit(state.copyWith(
              fri: state.fri.replaceAll('${event.method}:;', '')));
        } else {
          emit(state.copyWith(fri: '${state.fri}${event.method}:;'));
        }
      case AppString.sat:
        if (state.sat.contains(event.method)) {
          emit(state.copyWith(
              sat: state.sat.replaceAll('${event.method}:;', '')));
        } else {
          emit(state.copyWith(sat: '${state.sat}${event.method}:;'));
        }
      default:
        if (state.sun.contains(event.method)) {
          emit(state.copyWith(
              sun: state.sun.replaceAll('${event.method}:;', '')));
        } else {
          emit(state.copyWith(sun: '${state.sun}${event.method}:;'));
        }
    }
  }

  void _addExercise(ChooseExercise event, Emitter<AnalyticsToggleState> emit) {
    switch (state.count) {
      case AppString.mon:
        emit(state.copyWith(
            mon: MethodReused.exerciseResult(state, event.exercise)));

      case AppString.tue:
        emit(state.copyWith(
            tue: MethodReused.exerciseResult(state, event.exercise)));
      case AppString.wed:
        emit(state.copyWith(
            wed: MethodReused.exerciseResult(state, event.exercise)));
      case AppString.thu:
        emit(state.copyWith(
            thu: MethodReused.exerciseResult(state, event.exercise)));
      case AppString.fri:
        emit(state.copyWith(
            fri: MethodReused.exerciseResult(state, event.exercise)));
      case AppString.sat:
        emit(state.copyWith(
            sat: MethodReused.exerciseResult(state, event.exercise)));
      default:
        emit(state.copyWith(
            sun: MethodReused.exerciseResult(state, event.exercise)));
    }
  }

  void _removeExercise(
      UnChooseExercise event, Emitter<AnalyticsToggleState> emit) {
    switch (state.count) {
      case AppString.mon:
        emit(state.copyWith(
            mon: MethodReused.removeExercise(state, event.exercise)));

      case AppString.tue:
        emit(state.copyWith(
            tue: MethodReused.removeExercise(state, event.exercise)));
      case AppString.wed:
        emit(state.copyWith(
            wed: MethodReused.removeExercise(state, event.exercise)));
      case AppString.thu:
        emit(state.copyWith(
            thu: MethodReused.removeExercise(state, event.exercise)));
      case AppString.fri:
        emit(state.copyWith(
            fri: MethodReused.removeExercise(state, event.exercise)));
      case AppString.sat:
        emit(state.copyWith(
            sat: MethodReused.removeExercise(state, event.exercise)));
      default:
        emit(state.copyWith(
            sun: MethodReused.removeExercise(state, event.exercise)));
    }
  }

  _updateCount(UpdateCount event, Emitter<AnalyticsToggleState> emit) {
    switch (event.day) {
      case AppString.mon:
        emit(state.copyWith(count: AppString.tue));
      case AppString.tue:
        emit(state.copyWith(count: AppString.wed));
      case AppString.wed:
        emit(state.copyWith(count: AppString.thu));
      case AppString.thu:
        emit(state.copyWith(count: AppString.fri));
      case AppString.fri:
        emit(state.copyWith(count: AppString.sat));
      default:
        emit(state.copyWith(count: AppString.sun));
    }
  }

  _updateCountMethod(
      UpdateCountMethod event, Emitter<AnalyticsToggleState> emit) {
    emit(state.copyWith(countMethod: event.method));
  }

  _resetMuscleGroup(
      ResetMuscleGroup event, Emitter<AnalyticsToggleState> emit) {
    emit(state.copyWith(muscleGroup: ''));
  }

  Future<void> _submitWorkout(
      SubmitWorkoutSchedule event, Emitter<AnalyticsToggleState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));


    try {
      var listWorkoutSchedule =
          await DbAnalytics().getData(AppString.workoutSchedule);
      if (listWorkoutSchedule.isNotEmpty) {
        for (int i = 1; i <= listWorkoutSchedule.length; i++) {
          await DbAnalytics().update(AppString.workoutSchedule, i, 1);
        }
      }

      await DbAnalytics().insert(AppString.workoutSchedule, {
        AppString.dateTime:
            DateFormat('dd-M-yyyy HH:mm:ss').format(DateTime.now()),
        AppString.mon: state.mon,
        AppString.tue: state.tue,
        AppString.wed: state.wed,
        AppString.thu: state.thu,
        AppString.fri: state.fri,
        AppString.sat: state.sat,
        AppString.sun: state.sun,
        AppString.use: 0,
        AppString.activity: state.allDay.split(',').length - 1
      });
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  void _addCardioMethod(
      AddCardioMethod event, Emitter<AnalyticsToggleState> emit) {
        String value ='';
    for(int i =0; i< MethodReused.value(state, state.count).split(';').length -1 ;i++){
      if(MethodReused.value(state, state.count).split(';')[i].split(':')[0] == state.countMethod){
        value ='$value${MethodReused.value(state, state.count).split(';')[i].split(':')[0]}.${event.cardioMethod}:;' ;
      } else {
        value = '$value${MethodReused.value(state, state.count).split(';')[i]};';
      }
    }


      switch (state.count) {
      case AppString.mon:
         emit(state.copyWith(caridoMethod: event.cardioMethod,
         mon: value

    ));
      case AppString.tue:
        emit(state.copyWith(caridoMethod: event.cardioMethod,
         tue: value

    ));
      case AppString.wed:
        emit(state.copyWith(caridoMethod: event.cardioMethod,
         wed: value

    ));
      case AppString.thu:
        emit(state.copyWith(caridoMethod: event.cardioMethod,
        thu : value

    ));
      case AppString.fri:
         emit(state.copyWith(caridoMethod: event.cardioMethod,
         fri: value

    ));
      case AppString.sat:
       emit(state.copyWith(caridoMethod: event.cardioMethod,
         sat: value

    ));
      default:
        emit(state.copyWith(caridoMethod: event.cardioMethod,
         sun: value

    ));
    }
   
  }
}
