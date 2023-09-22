part of 'analytics_toggle_bloc.dart';

sealed class AnalyticsToggleEvent extends Equatable {
  const AnalyticsToggleEvent();

  @override
  List<Object> get props => [];
}

class AddDayOff extends AnalyticsToggleEvent {
  final String day;
  final int dayOffMin;

  const AddDayOff(this.dayOffMin, this.day);
}

class ChooseMuscleGroupSelection extends AnalyticsToggleEvent {
  final String muscleGroup;
  const ChooseMuscleGroupSelection(this.muscleGroup);
}

class UnChooseMuscleGroupSelection extends AnalyticsToggleEvent {
  final String muscleGroup;
  const UnChooseMuscleGroupSelection(this.muscleGroup);
}

class ChooseExercise extends AnalyticsToggleEvent {
  final String exercise;
  final String day;
  const ChooseExercise(this.day, this.exercise);
}

class UnChooseExercise extends AnalyticsToggleEvent {
  final String exercise;
  final String day;
  const UnChooseExercise(this.day, this.exercise);
}

class UpdateCount extends AnalyticsToggleEvent {
  final String day;
  const UpdateCount(this.day);
}

class UpdateCountMethod extends AnalyticsToggleEvent {
  final String method;
  const UpdateCountMethod(this.method);
}

class AddDayOffDay extends AnalyticsToggleEvent {
  final String day;
  const AddDayOffDay(this.day);
}

class ResetMuscleGroup extends AnalyticsToggleEvent {}

class AddExerciseMethod extends AnalyticsToggleEvent {
  final String method;
  final String day;
  const AddExerciseMethod(this.method, this.day);
}

class SubmitWorkoutSchedule extends AnalyticsToggleEvent {}
