import 'package:equatable/equatable.dart';
import 'package:chronometer/app/main/models/index.dart';

abstract class PreferencesState extends Equatable {
  const PreferencesState([List props = const []]);

  @override
  List<Object> get props => [props];
}

class PreferencesNotLoaded extends PreferencesState {
  @override
  List<Object> get props => [];
}

class PreferencesLoaded extends PreferencesState {
  final Theme theme;

  const PreferencesLoaded({required this.theme});

  @override
  List<Object> get props => [theme];

  @override
  String toString() => '$runtimeType: { $theme }';
}
