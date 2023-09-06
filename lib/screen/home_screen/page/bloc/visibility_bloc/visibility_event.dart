part of 'visibility_bloc.dart';

abstract class VisibilityEvent extends Equatable {
  const VisibilityEvent();

  @override
  List<Object> get props => [];
}

class PracticeEvent extends VisibilityEvent {
  final int exercise;
  final int set;
  const PracticeEvent(this.exercise, this.set);
}

class RestTimeEvent extends VisibilityEvent {}
