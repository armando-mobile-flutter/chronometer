import 'package:chronometer/app/main/blocs/preferences/preferences_event.dart';
import 'package:chronometer/app/main/blocs/preferences/preferences_state.dart';
import 'package:chronometer/app/main/repositories/preferences_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chronometer/app/main/shared/screen/index.dart';
import 'package:chronometer/app/main/blocs/index.dart';
import 'package:chronometer/app/main/repositories/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = BlocDelegate();

  final preferencesRepository = PreferencesRepository();
  final preferenceBloc =
      PreferencesBloc(preferencesRepository: preferencesRepository);
  preferenceBloc.stream
      .firstWhere((state) => state is PreferencesLoaded)
      .then((_) => runApp(App(
            preferencesRepository: preferencesRepository,
            preferencesBloc: preferenceBloc,
          )));

  preferenceBloc.add(LoadPreferences());
}
