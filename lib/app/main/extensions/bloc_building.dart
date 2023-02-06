import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chronometer/app/main/blocs/delegate_bloc.dart';
import 'package:chronometer/app/main/blocs/preferences/preferences_bloc.dart';
import 'package:chronometer/app/main/blocs/preferences/preferences_event.dart';
import 'package:chronometer/app/main/blocs/preferences/preferences_state.dart';
import 'package:chronometer/app/main/interfaces/ipreferences_repository.dart';
import 'package:chronometer/app/main/repositories/preferences_repository.dart';

class BlocBuilding {
  static BlocBuilding? _instance;
  IPreferencesRepository? _preferencesRepository;
  PreferencesBloc? _preferencesBloc;

  BlocBuilding._() {
    _preferencesRepository = PreferencesRepository();
    _preferencesBloc =
        PreferencesBloc(preferencesRepository: preferencesRepository!);
  }

  static BlocBuilding get _getInstance {
    _instance ??= BlocBuilding._();

    return _instance!;
  }

  IPreferencesRepository? get preferencesRepository => _preferencesRepository;
  PreferencesBloc? get preferencesBloc => _preferencesBloc;

  static BlocBuilding initialize() => BlocBuilding._getInstance;

  void useDelegates() {
    Bloc.observer = BlocDelegate();
  }

  void runWithPrefereces(Widget widget) {
    preferencesBloc!.stream
        .firstWhere((state) => state is PreferencesLoaded)
        .then((_) => runApp(widget));
    preferencesBloc!.add(LoadPreferences());
  }
}
