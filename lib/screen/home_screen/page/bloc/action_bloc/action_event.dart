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

class AddTemporarySuperSet extends ActionEvent {
  final String exercise;
  const AddTemporarySuperSet(this.exercise);
}

class AddTemporaryDropSet extends ActionEvent {
  final String exercise;
  const AddTemporaryDropSet(this.exercise);
}

class UpdateSuperSet extends ActionEvent {}

class UpdateDropSet extends ActionEvent {}

class UnChooseExercise extends ActionEvent {
  final String exercise;
  const UnChooseExercise(this.exercise);
}

class ChooseSet extends ActionEvent {
  final String value;
  final int index;
  final int lenght;
  final String exercise;
  const ChooseSet(this.value, this.index, this.lenght, this.exercise);
}

class ChooseRestTime extends ActionEvent {
  final String value;
  final int index;
  final int lenght;
  final String exercise;
  const ChooseRestTime(this.value, this.index, this.lenght, this.exercise);
}

class ChooseRestTimeDrop extends ActionEvent {
  final String value;
  final int index;
  final int lenght;
  final String exercise;
  const ChooseRestTimeDrop(this.value, this.index, this.lenght, this.exercise);
}

class ChooseSetDrop extends ActionEvent {
  final String value;
  final int index;
  final int lenght;
  final String exercise;
  const ChooseSetDrop(this.value, this.index, this.lenght, this.exercise);
}

class SetExercise extends ActionEvent {
  final String exercise;
  const SetExercise(this.exercise);
}

class IndexPage extends ActionEvent {
  final int index;
  const IndexPage(this.index);
}
