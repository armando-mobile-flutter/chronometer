import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chronometer/app/main/blocs/stopwatch/stopwatch_event.dart';
import 'package:chronometer/app/main/blocs/stopwatch/stopwatch_state.dart';

class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  int _elapsedTimeInMiliSeconds = 0;
  StreamSubscription? _streamPeriodSubscription;

  StopwatchBloc({StopwatchState? initalState})
      : super(initalState ?? StopwatchState.initial()) {
    on<StartStopwatch>(_onStartStopwatch);
    on<UpdateStopwatch>(_onUpdateStopwatch);
    on<StopStopwatch>(_onStopStopwatch);
    on<ResetStopwatch>(_onResetStopwatch);
  }

  void _onDispose() {
    _streamPeriodSubscription?.cancel();
    _streamPeriodSubscription = null;
  }

  void _onStartStopwatch(StartStopwatch event, Emitter<StopwatchState> emit) =>
      (_streamPeriodSubscription = (_streamPeriodSubscription == null)
          ? Stream.periodic(const Duration(milliseconds: 10)).listen((_) {
              _elapsedTimeInMiliSeconds += 10;
              add(UpdateStopwatch(
                  Duration(milliseconds: _elapsedTimeInMiliSeconds)));
            })
          : _streamPeriodSubscription);

  void _onUpdateStopwatch(UpdateStopwatch event, Emitter<StopwatchState> emit) {
    final isSpecial = event.time.inMilliseconds % 3000 == 0;

    emit(StopwatchState(
        time: event.time,
        isInitial: false,
        isRunning: true,
        isSpecial: isSpecial));
  }

  void _onStopStopwatch(StopStopwatch event, Emitter<StopwatchState> emit) {
    _onDispose();

    emit(state.copyWith(isRunning: false));
  }

  void _onResetStopwatch(ResetStopwatch event, Emitter<StopwatchState> emit) {
    _elapsedTimeInMiliSeconds = 0;

    if (!state.isRunning) emit(StopwatchState.initial());
  }

  @override
  Future<void> close() {
    _onDispose();

    return super.close();
  }
}
