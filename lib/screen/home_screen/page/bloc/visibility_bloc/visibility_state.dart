// ignore_for_file: must_be_immutable

part of 'visibility_bloc.dart';

abstract class VisibilityState extends Equatable {
  VisibilityState(this.exercise, this.set);
  int set;
  final int exercise;

  @override
  List<Object> get props => [set, exercise];
}

class VisibilityInitial extends VisibilityState {
  VisibilityInitial(super.exercise, super.set);
}

class PracticeState extends VisibilityState {
  PracticeState(super.exercise, super.set);
}

class RestTimeState extends VisibilityState {
  RestTimeState(super.exercise, super.set);
}

class DoneState extends VisibilityState {
  DoneState(super.exercise, super.set);
}
