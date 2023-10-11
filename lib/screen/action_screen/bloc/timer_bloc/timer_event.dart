part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStartedRestTime extends TimerEvent {
  final int duration;
  final int timeBegin;
  const TimerStartedRestTime({required this.duration, required this.timeBegin});
}

class TimerStartedSet extends TimerEvent {
  final int duration;

  const TimerStartedSet({required this.duration});
}

class TimerCompleted extends TimerEvent {
  const TimerCompleted();
}

class _TimerTickerSet extends TimerEvent {
  final int duration;

  const _TimerTickerSet(
    this.duration,
  );
}

class StopSet extends TimerEvent {}

class _TimerTickerResTime extends TimerEvent {
  final int duration;
  final int timeBegin;
  const _TimerTickerResTime(this.duration, this.timeBegin);
}
