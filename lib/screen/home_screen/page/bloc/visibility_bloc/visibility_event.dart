part of 'visibility_bloc.dart';

abstract class VisibilityEvent extends Equatable {
  const VisibilityEvent();

  @override
  List<Object> get props => [];
}

class PracticeEvent extends VisibilityEvent {
  final int exercise;
  final int set;
  final int setDrop;
  final String exerciseName;
  final String nextExerciseName;
  const PracticeEvent(this.exercise, this.set, this.setDrop, this.exerciseName,
      this.nextExerciseName);
}

class VisibilityAdd extends VisibilityEvent {
  final String exercise;
  const VisibilityAdd(this.exercise);
}

class VisibilityReset extends VisibilityEvent {}

class PracticeCardioEvent extends VisibilityEvent {
  final int exercise;
  final int set;
  final int level;
  const PracticeCardioEvent(this.exercise, this.set, this.level);
}

class DoneEvent extends VisibilityEvent {}

class RestTimeEvent extends VisibilityEvent {}
