part of 'action_bloc.dart';

abstract class ActionEvent extends Equatable {
  const ActionEvent();

  @override
  List<Object> get props => [];
}

class ChooseExerciseMethod extends ActionEvent {
  final String method;
  const ChooseExerciseMethod(this.method);
}

class ChooseMuscleGroupSelection extends ActionEvent {
  final String muscleGroup;
  const ChooseMuscleGroupSelection(this.muscleGroup);
}

class UnChooseMuscleGroupSelection extends ActionEvent {
  final String muscleGroup;
  const UnChooseMuscleGroupSelection(this.muscleGroup);
}

class ChooseExercise extends ActionEvent {
  final String exercise;
  const ChooseExercise(this.exercise);
}

class UnChooseExercise extends ActionEvent {
  final String exercise;
  const UnChooseExercise(this.exercise);
}

class ChooseSet extends ActionEvent {
  final String value;
  final int index;
  final int lenght;
  const ChooseSet(this.value, this.index, this.lenght);
}

class ChooseRestTime extends ActionEvent {
  final String value;
  final int index;
  final int lenght;
  const ChooseRestTime(this.value, this.index, this.lenght);
}
