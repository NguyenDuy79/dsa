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


// class TimerRestTimeCompletedState extends TimerState {
//   const TimerRestTimeCompletedState() : super(0);
// }

// class TimerSetCompletedState extends TimerState {
//   const TimerSetCompletedState(super.duration);
// }

// class TimerRunInProgress extends TimerState {
//   const TimerRunInProgress(super.duration);
//   @override
//   String toString() {
//     '$duration';

//     return super.toString();
//   }
// }
