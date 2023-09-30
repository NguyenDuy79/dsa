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

class ChooseSetCardio extends ActionEvent {
  final String value;
  const ChooseSetCardio(this.value);
}

class ChooseRestTimeCardio extends ActionEvent {
  final String value;
  const ChooseRestTimeCardio(this.value);
}

class ChooseTime extends ActionEvent {
  final String value;
  const ChooseTime(this.value);
}

class ChooseRestTime extends ActionEvent {
  final String value;
  final int index;
  final int lenght;
  final String exercise;
  const ChooseRestTime(this.value, this.index, this.lenght, this.exercise);
}

class Submit extends ActionEvent {
  final bool submit;
  const Submit(this.submit);
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

class ChooseCardioMethod extends ActionEvent {
  final String methodCardio;
  const ChooseCardioMethod(this.methodCardio);
}

class ChooseHiitMethod extends ActionEvent {
  final String method;
  const ChooseHiitMethod(this.method);
}

class SetLevel extends ActionEvent {
  final String level;
  const SetLevel(this.level);
}

class UpdateCountLevel extends ActionEvent {}

class ReturnCountLevel extends ActionEvent {}

class ChooseExerciseHiitGroup extends ActionEvent {
  final String exercise;
  final int countLevel;
  const ChooseExerciseHiitGroup(this.exercise, this.countLevel);
}

class UpdateExercise extends ActionEvent {
  final int level;
  const UpdateExercise(this.level);
}

class ResetField extends ActionEvent {}

class ResetRemaining extends ActionEvent {}

class ResetExerciseToNormal extends ActionEvent {}

class LissCardioExercise extends ActionEvent {
  final String exercise;
  const LissCardioExercise(this.exercise);
}
