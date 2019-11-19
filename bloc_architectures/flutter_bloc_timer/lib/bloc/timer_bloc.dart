import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_timer/repository/my_timer.dart';

import './bloc.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final MyTimer _timer;
  final int _initDuration = 60; // sec

  StreamSubscription<int> _timerSubscription;

  TimerBloc({@required MyTimer timer})
      : assert(timer != null),
        _timer = timer;

  @override
  TimerState get initialState => Ready(_initDuration);

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is Start) {
      yield* _mapStartToState(event);
    }
    if (event is Pause) {
      yield* _mapPauseToState(event);
    }
    if (event is Resume) {
      yield* _mapResumeToState(event);
    }
    if (event is Reset) {
      yield* _mapResetToState(event);
    }
    if (event is Tick) {
      yield* _mapTickToState(event);
    }
  }

  Stream<TimerState> _mapStartToState(Start start) async* {
    if (state is Ready) {
      yield Running(start.duration);
      _timerSubscription?.cancel();
      _timerSubscription = _timer
          .tick(ticks: start.duration)
          .listen((duration) => add(Tick(duration: duration)));
    }
  }

  Stream<TimerState> _mapPauseToState(Pause pause) async* {
    if (state is Running) {
      _timerSubscription?.pause();
      yield Paused(state.duration);
    }
  }

  Stream<TimerState> _mapResumeToState(Resume resume) async* {
    if (state is Paused) {
      _timerSubscription?.resume();
      yield Running(state.duration);
    }
  }

  Stream<TimerState> _mapResetToState(Reset reset) async* {
    _timerSubscription?.cancel();
    yield Ready(_initDuration);
  }

  Stream<TimerState> _mapTickToState(Tick tick) async* {
    yield tick.duration > 0 ? Running(tick.duration) : Finished();
  }

  @override
  Future<void> close() {
    _timerSubscription?.cancel();
    return super.close();
  }
}
