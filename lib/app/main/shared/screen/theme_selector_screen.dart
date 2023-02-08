import 'package:chronometer/app/main/blocs/preferences/preferences_event.dart';
import 'package:chronometer/app/main/blocs/preferences/preferences_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:chronometer/app/main/models/theme.dart';
import 'package:chronometer/app/main/blocs/preferences/preferences_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chronometer/app/main/shared/utils/index.dart';

class ThemeSelectorScreen extends StatelessWidget {
  const ThemeSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final preferencesBloc = BlocProvider.of<PreferencesBloc>(context);

    return defaultTargetPlatform == TargetPlatform.iOS
        ? _IOSThemeSelectorScreen(bloc: preferencesBloc)
        : _AndroidThemeSelectorScreen(bloc: preferencesBloc);
  }
}

class _IOSThemeSelectorScreen extends StatelessWidget {
  const _IOSThemeSelectorScreen({super.key, required this.bloc});
  final PreferencesBloc bloc;

  String _themeToString(Theme theme) {
    String themeSelected;

    switch (theme) {
      case Theme.light:
        themeSelected = 'Light';
        break;
      case Theme.dart:
        themeSelected = 'Dart';
        break;
    }

    return themeSelected;
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Theme'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: Icon(CupertinoIcons.back,
              size: 32, color: BuildTheme.getIOSIconColor(context)),
        ),
      ),
      child: BlocBuilder<PreferencesBloc, PreferencesState>(
          builder: (context, state) => (state is PreferencesLoaded)
              ? ListView.builder(
                  itemCount: Theme.values.length,
                  itemBuilder: (context, index) => CupertinoListTile.notched(
                        title: Text(_themeToString(Theme.values[index])),
                        onTap: () => bloc.add(UpdateTheme(Theme.values[index])),
                      ))
              : Container()));
}

class _AndroidThemeSelectorScreen extends StatelessWidget {
  const _AndroidThemeSelectorScreen({super.key, required this.bloc});
  final PreferencesBloc bloc;

  String _themeToString(Theme theme) {
    String themeSelected;

    switch (theme) {
      case Theme.light:
        themeSelected = 'Light';
        break;
      case Theme.dart:
        themeSelected = 'Dart';
        break;
    }

    return themeSelected;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Theme'),
      ),
      body: BlocBuilder<PreferencesBloc, PreferencesState>(
          builder: (context, state) => (state is PreferencesLoaded)
              ? ListView.builder(
                  itemCount: Theme.values.length,
                  itemBuilder: (context, index) => RadioListTile(
                      title: Text(_themeToString(Theme.values[index])),
                      value: Theme.values[index],
                      groupValue: state.theme,
                      onChanged: (Theme? theme) {
                        bloc.add(UpdateTheme(theme!));
                      }),
                )
              : Container()));
}
