import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chronometer/app/main/extensions/index.dart';
import 'package:chronometer/app/main/shared/screen/main_screen.dart';
import 'package:chronometer/app/main/blocs/index.dart';
import 'package:chronometer/app/main/blocs/preferences/preferences_state.dart';
import 'package:chronometer/app/main/shared/utils/index.dart';
import 'package:chronometer/app/main/models/index.dart';

class App extends StatelessWidget {
  final blocBuilding = BlocBuilding.initialize();
  final String title = 'Chronometer';
  App({super.key});

  @override
  Widget build(BuildContext context) => RepositoryRegistration(
      blocBuilding: blocBuilding,
      child: BlocRegitration(
          blocBuilding: blocBuilding,
          child: BlocBuilder<PreferencesBloc, PreferencesState>(
            builder: (context, state) =>
                (defaultTargetPlatform == TargetPlatform.iOS)
                    ? _IOSApp(
                        title: title,
                        theme: state is PreferencesLoaded
                            ? BuildTheme.getCupertinoTheme(state.theme)
                            : BuildTheme.getCupertinoTheme(Theme.dart))
                    : _AndroidApp(
                        title: title,
                        theme: state is PreferencesLoaded
                            ? BuildTheme.getMaterialTheme(state.theme)
                            : BuildTheme.getMaterialTheme(Theme.dart)),
          )));
}

class _IOSApp extends StatelessWidget {
  const _IOSApp({super.key, required this.title, required this.theme});
  final CupertinoThemeData theme;
  final String title;

  @override
  Widget build(BuildContext context) => CupertinoApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: theme,
        home: const MainScreen(),
      );
}

class _AndroidApp extends StatelessWidget {
  const _AndroidApp({super.key, required this.title, required this.theme});
  final ThemeData theme;
  final String title;

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: theme,
        home: const MainScreen(),
      );
}
