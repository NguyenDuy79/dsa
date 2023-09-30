part of 'timer_bloc.dart';

class TimerState extends Equatable {
  const TimerState(this.duration, this.timeBegin);
  final int duration;
  final int timeBegin;

  @override
  List<Object> get props => [duration, timeBegin];
}

class TimerInitial extends TimerState {
  const TimerInitial(super.duration, super.timeBegin);
}
