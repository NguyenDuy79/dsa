// ignore_for_file: must_be_immutable

part of 'visibility_bloc.dart';

abstract class VisibilityState extends Equatable {
  const VisibilityState(
      this.exercise, this.set, this.setDrop, this.exerciseName);
  final int setDrop;

  final int set;

  final int exercise;
  final String exerciseName;

  @override
  List<Object> get props => [set, exercise, setDrop];
}

class VisibilityInitial extends VisibilityState {
  const VisibilityInitial(
      super.exercise, super.set, super.setDrop, super.exerciseName);
  @override
  List<Object> get props => [set, exercise, setDrop];
}

class PracticeState extends VisibilityState {
  const PracticeState(
      super.exercise, super.set, super.setDrop, super.exerciseName);
  @override
  List<Object> get props => [set, exercise, setDrop];
}

class RestTimeState extends VisibilityState {
  const RestTimeState(
      super.exercise, super.set, super.setDrop, super.exericseName);

  @override
  List<Object> get props => [set, exercise, setDrop, exerciseName];
}

class DoneState extends VisibilityState {
  const DoneState(super.exercise, super.set, super.setDrop, super.exerciseName);
  @override
  List<Object> get props => [set, exercise, setDrop];
}
