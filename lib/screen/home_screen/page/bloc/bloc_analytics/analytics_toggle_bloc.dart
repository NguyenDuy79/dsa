import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app_bloc/config/config.dart';
import 'package:fitness_app_bloc/db/database_analytics.dart';
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
    switch (event.day) {
      case AppString.mon:
        String mon = '';
        for (int i = 0; i < state.mon.split(';').length - 1; i++) {
          if (state.mon.split(';')[i].split(':')[0] == state.countMethod) {
            mon = '$mon${state.mon.split(';')[i]}${event.exercise},;';
          } else {
            mon = '$mon${state.mon.split(';')[i]};';
          }
        }
        emit(state.copyWith(mon: mon));

      case AppString.tue:
        String tue = '';
        for (int i = 0; i < state.tue.split(';').length - 1; i++) {
          if (state.tue.split(';')[i].split(':')[0] == state.countMethod) {
            tue = '$tue${state.tue.split(';')[i]}${event.exercise},;';
          } else {
            tue = '$tue${state.tue.split(';')[i]};';
          }
        }
        emit(state.copyWith(tue: tue));
      case AppString.wed:
        String tue = '';
        for (int i = 0; i < state.wed.split(';').length - 1; i++) {
          if (state.wed.split(';')[i].split(':')[0] == state.countMethod) {
            tue = '$tue${state.wed.split(';')[i]}${event.exercise},;';
          } else {
            tue = '$tue${state.wed.split(';')[i]};';
          }
        }
        emit(state.copyWith(wed: tue));
      case AppString.thu:
        String tue = '';
        for (int i = 0; i < state.thu.split(';').length - 1; i++) {
          if (state.thu.split(';')[i].split(':')[0] == state.countMethod) {
            tue = '$tue${state.thu.split(';')[i]}${event.exercise},;';
          } else {
            tue = '$tue${state.thu.split(';')[i]};';
          }
        }
        emit(state.copyWith(thu: tue));
      case AppString.fri:
        String tue = '';
        for (int i = 0; i < state.fri.split(';').length - 1; i++) {
          if (state.fri.split(';')[i].split(':')[0] == state.countMethod) {
            tue = '$tue${state.fri.split(';')[i]}${event.exercise},;';
          } else {
            tue = '$tue${state.fri.split(';')[i]};';
          }
        }
        emit(state.copyWith(fri: tue));
      case AppString.sat:
        String tue = '';
        for (int i = 0; i < state.sat.split(';').length - 1; i++) {
          if (state.sat.split(';')[i].split(':')[0] == state.countMethod) {
            tue = '$tue${state.sat.split(';')[i]}${event.exercise},;';
          } else {
            tue = '$tue${state.sat.split(';')[i]};';
          }
        }
        emit(state.copyWith(sat: tue));
      default:
        String tue = '';
        for (int i = 0; i < state.sun.split(';').length - 1; i++) {
          if (state.sun.split(';')[i].split(':')[0] == state.countMethod) {
            tue = '$tue${state.sun.split(';')[i]}${event.exercise},;';
          } else {
            tue = '$tue${state.sun.split(';')[i]};';
          }
        }
        emit(state.copyWith(sun: tue));
    }
  }

  void _removeExercise(
      UnChooseExercise event, Emitter<AnalyticsToggleState> emit) {
    switch (event.day) {
      case AppString.mon:
        String mon = '';
        for (int i = 0; i < state.mon.split(';').length - 1; i++) {
          if (state.mon.split(';')[i].split(':')[0] == state.countMethod) {
            mon =
                '$mon${state.mon.split(';')[i].replaceAll('${event.exercise},', '')};';
          } else {
            mon = '$mon${state.mon.split(';')[i]};';
          }
        }

        emit(state.copyWith(mon: mon));

      case AppString.tue:
        String mon = '';
        for (int i = 0; i < state.tue.split(';').length - 1; i++) {
          if (state.tue.split(';')[i].split(':')[0] == state.countMethod) {
            mon =
                '$mon${state.tue.split(';')[i].replaceAll('${event.exercise},', '')};';
          } else {
            mon = '$mon${state.tue.split(';')[i]};';
          }
        }
        emit(state.copyWith(tue: mon));
      case AppString.wed:
        String mon = '';
        for (int i = 0; i < state.wed.split(';').length - 1; i++) {
          if (state.wed.split(';')[i].split(':')[0] == state.countMethod) {
            mon =
                '$mon${state.wed.split(';')[i].replaceAll('${event.exercise},', '')};';
          } else {
            mon = '$mon${state.wed.split(';')[i]};';
          }
        }
        emit(state.copyWith(wed: mon));
      case AppString.thu:
        String mon = '';
        for (int i = 0; i < state.thu.split(';').length - 1; i++) {
          if (state.thu.split(';')[i].split(':')[0] == state.countMethod) {
            mon =
                '$mon${state.thu.split(';')[i].replaceAll('${event.exercise},', '')};';
          } else {
            mon = '$mon${state.thu.split(';')[i]};';
          }
        }
        emit(state.copyWith(thu: mon));
      case AppString.fri:
        String mon = '';
        for (int i = 0; i < state.fri.split(';').length - 1; i++) {
          if (state.fri.split(';')[i].split(':')[0] == state.countMethod) {
            mon =
                '$mon${state.fri.split(';')[i].replaceAll('${event.exercise},', '')};';
          } else {
            mon = '$mon${state.fri.split(';')[i]};';
          }
        }
        emit(state.copyWith(fri: mon));
      case AppString.sat:
        String mon = '';
        for (int i = 0; i < state.sat.split(';').length - 1; i++) {
          if (state.sat.split(';')[i].split(':')[0] == state.countMethod) {
            mon =
                '$mon${state.sat.split(';')[i].replaceAll('${event.exercise},', '')};';
          } else {
            mon = '$mon${state.sat.split(';')[i]};';
          }
        }
        emit(state.copyWith(sat: mon));
      default:
        String mon = '';
        for (int i = 0; i < state.sun.split(';').length - 1; i++) {
          if (state.sun.split(';')[i].split(':')[0] == state.countMethod) {
            mon =
                '$mon${state.sun.split(';')[i].replaceAll('${event.exercise},', '')};';
          } else {
            mon = '$mon${state.sun.split(';')[i]};';
          }
        }
        emit(state.copyWith(sun: mon));
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
}
