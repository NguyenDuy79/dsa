import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app_bloc/common_app/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;

  StreamSubscription? _subcription;
  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const TimerInitial(0, 0)) {
    on<TimerStartedRestTime>(_startedRestTime);
    on<_TimerTickerResTime>(_onTickedResTime);
    on<TimerStartedSet>(_startSet);
    on<_TimerTickerSet>(_onTickerSet);
    on<TimerCompleted>(_completed);
    //on<TimerCompleted>(_onCompleted);
  }
  void _startedRestTime(TimerStartedRestTime event, Emitter<TimerState> emit) {
    _subcription?.cancel();
    emit(TimerState(event.duration, event.timeBegin));

    _subcription = _ticker.tickRestTime(ticks: event.duration).listen((item) {
      add(_TimerTickerResTime(item, event.timeBegin));
    });
  }

  void _onTickedResTime(_TimerTickerResTime event, Emitter<TimerState> emit) {
    emit(TimerState(event.duration, event.timeBegin));
    // if (event.duration > 0) {
    //   emit(state);
    // } else {
    //   emit(const TimerRestTimeCompletedState());
    // }
  }

  void _startSet(TimerStartedSet event, Emitter<TimerState> emit) {
    _subcription?.cancel();
    emit(TimerState(event.duration, 0));

    _subcription = _ticker.tickSet(ticks: event.duration).listen((event) {
      add(_TimerTickerSet(event));
    });
  }

  void _onTickerSet(_TimerTickerSet event, Emitter<TimerState> emit) {
    emit(TimerState(event.duration, 0));
  }

  void _completed(TimerCompleted event, Emitter<TimerState> emit) {
    _subcription?.cancel();
    emit(const TimerState(0, 0));
  }

  // void _onCompleted(TimerCompleted event, Emitter<TimerState> emit) {
  //   emit(TimerSetCompletedState(event.duration));
  // }

  @override
  Future<void> close() {
    _subcription?.cancel();
    return super.close();
  }
}
