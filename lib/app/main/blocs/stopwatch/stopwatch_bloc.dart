import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chronometer/app/main/blocs/stopwatch/stopwatch_event.dart';
import 'package:chronometer/app/main/blocs/stopwatch/stopwatch_state.dart';

class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  int _elapsedTimeInMiliSeconds = 0;
  StreamSubscription? _streamPeriodSubscription;

  StopwatchBloc({StopwatchState? initalState})
      : super(initalState ?? StopwatchState.initial()) {
    on<StartStopwatch>((event, emit) {
      _streamPeriodSubscription = (_streamPeriodSubscription == null)
          ? Stream.periodic(const Duration(milliseconds: 10)).listen((_) {
              _elapsedTimeInMiliSeconds += 10;
              return add(UpdateStopwatch(
                  Duration(milliseconds: _elapsedTimeInMiliSeconds)));
            })
          : _streamPeriodSubscription;
    });

    on<UpdateStopwatch>((event, emit) {
      final isSpecial = event.time.inMilliseconds % 3000 == 0;

      return emit(StopwatchState(
          time: event.time,
          isInitial: false,
          isRunning: true,
          isSpecial: isSpecial));
    });

    on<StopStopwatch>((event, emit) {
      _onDispose();

      return emit(state.copyWith(isRunning: false));
    });

    on<ResetStopwatch>((event, emit) {
      _elapsedTimeInMiliSeconds = 0;

      if (!state.isRunning) {
        return emit(StopwatchState.initial());
      }
    });
  }

  void _onDispose() {
    _streamPeriodSubscription?.cancel();
    _streamPeriodSubscription = null;
  }

  @override
  Future<void> close() {
    _onDispose();

    return super.close();
  }
}
