import 'package:equatable/equatable.dart';
import 'package:chronometer/app/main/models/index.dart';

abstract class PreferencesEvent extends Equatable {
  const PreferencesEvent([List props = const []]);

  @override
  List<Object> get props => [props];
}

class LoadPreferences extends PreferencesEvent {
  @override
  List<Object> get props => [];
}

class UpdateTheme extends PreferencesEvent {
  final Theme theme;

  UpdateTheme(this.theme) : super([theme]);

  @override
  String toString() => '$runtimeType: { $theme }';
}
