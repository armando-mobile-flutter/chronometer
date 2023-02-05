import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chronometer/app/main/shared/screen/main_screen.dart';
import 'package:chronometer/app/main/interfaces/index.dart';
import 'package:chronometer/app/main/blocs/index.dart';
import 'package:chronometer/app/main/blocs/preferences/preferences_state.dart';
import 'package:chronometer/app/main/shared/utils/index.dart';
import 'package:chronometer/app/main/models/index.dart';

class App extends StatelessWidget {
  final IPreferencesRepository preferencesRepository;
  final PreferencesBloc preferencesBloc;

  const App(
      {key, required this.preferencesRepository, required this.preferencesBloc})
      : assert(preferencesRepository != null),
        assert(preferencesBloc != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
          providers: [
            RepositoryProvider<IPreferencesRepository>.value(
                value: preferencesRepository)
          ],
          child: MultiBlocProvider(
              providers: [
                BlocProvider<PreferencesBloc>.value(value: preferencesBloc),
                BlocProvider<CounterBloc>(create: (context) => CounterBloc()),
                BlocProvider<StopwatchBloc>(
                    create: (context) => StopwatchBloc())
              ],
              child: BlocBuilder<PreferencesBloc, PreferencesState>(
                builder: (context, state) =>
                    (defaultTargetPlatform == TargetPlatform.iOS)
                        ? _IOSApp(
                            theme: state is PreferencesLoaded
                                ? BuildTheme.getCupertinoTheme(state.theme)
                                : BuildTheme.getCupertinoTheme(Theme.dart))
                        : _AndroidApp(
                            theme: state is PreferencesLoaded
                                ? BuildTheme.getMaterialTheme(state.theme)
                                : BuildTheme.getMaterialTheme(Theme.dart)),
              )));
}

class _IOSApp extends StatelessWidget {
  const _IOSApp({super.key, required this.theme});
  final CupertinoThemeData theme;

  @override
  Widget build(BuildContext context) => CupertinoApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const MainScreen(),
      );
}

class _AndroidApp extends StatelessWidget {
  const _AndroidApp({super.key, required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chronometer',
        theme: theme,
        home: const MainScreen(),
      );
}
