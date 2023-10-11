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

  const ChooseExercise(this.exercise);
}

class UnChooseExercise extends AnalyticsToggleEvent {
  final String exercise;

  const UnChooseExercise(this.exercise);
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

class ChangePage extends AnalyticsToggleEvent {
  final int index;
  const ChangePage(this.index);
}

class AddCardioMethod extends AnalyticsToggleEvent {
  final String cardioMethod;
  const AddCardioMethod(this.cardioMethod);
}

class ChooseExerciseCardio extends AnalyticsToggleEvent {
  final bool value;
  const ChooseExerciseCardio(this.value);
}

class AddLevel extends AnalyticsToggleEvent {
  final String level;
  const AddLevel(this.level);
}

class UpdateExericse extends AnalyticsToggleEvent {}

class ChooseHiitMethod extends AnalyticsToggleEvent {
  final String hiitMethod;
  const ChooseHiitMethod(this.hiitMethod);
}

class UpdateCountLevel extends AnalyticsToggleEvent {
  final bool increase;
  const UpdateCountLevel(this.increase);
}

class ResetDataCardio extends AnalyticsToggleEvent {}
