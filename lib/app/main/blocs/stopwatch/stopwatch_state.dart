import 'package:equatable/equatable.dart';

class StopwatchState extends Equatable {
  final Duration time;
  final bool isInitial;
  final bool isRunning;
  final bool isSpecial;

  const StopwatchState(
      {required this.time,
      required this.isInitial,
      required this.isRunning,
      required this.isSpecial});

  @override
  List<Object> get props => [time, isInitial, isRunning, isSpecial];

  factory StopwatchState.initial() => const StopwatchState(
      time: Duration(milliseconds: 0),
      isInitial: true,
      isRunning: false,
      isSpecial: false);

  int get minutes => time.inMinutes;
  int get seconds => time.inSeconds;
  int get hundredths => (time.inMilliseconds / 10).floor().remainder(60);

  String get timeFormated {
    String toTwoDigits(int n) => (n >= 10) ? '$n' : '0$n';

    return '${toTwoDigits(minutes)}:${toTwoDigits(seconds)}:${toTwoDigits(hundredths)}';
  }

  StopwatchState copyWith(
          {Duration? time,
          bool? isInitial,
          bool? isRunning,
          bool? isSpecial}) =>
      StopwatchState(
          time: time ?? this.time,
          isInitial: isInitial ?? this.isInitial,
          isRunning: isRunning ?? this.isRunning,
          isSpecial: isSpecial ?? this.isSpecial);

  @override
  String toString() =>
      'StopwatchState { timeFormated: $timeFormated, isInitial: $isInitial, isRunning: $isRunning, isSpecial: $isSpecial}';
}
