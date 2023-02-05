import 'package:equatable/equatable.dart';

abstract class StopwatchEvent extends Equatable {
  const StopwatchEvent([List props = const []]);

  @override
  List<Object> get props => [props];
}

class StartStopwatch extends StopwatchEvent {
  @override
  String toString() => 'Start ===> Stopwatch';
}

class StopStopwatch extends StopwatchEvent {
  @override
  String toString() => 'Stop ===> Stopwatch';
}

class ResetStopwatch extends StopwatchEvent {
  @override
  String toString() => 'Reset ===> Stopwatch';
}

class UpdateStopwatch extends StopwatchEvent {
  UpdateStopwatch(this.time) : super([time]);
  final Duration time;

  @override
  String toString() =>
      'Update ===> Stopwatch {timeInMiliseconds: ${time.inMilliseconds}}';
}
