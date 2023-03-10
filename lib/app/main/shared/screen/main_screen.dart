import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chronometer/app/main/blocs/index.dart';
import 'package:chronometer/app/main/blocs/stopwatch/stopwatch_event.dart';
import 'package:chronometer/app/main/blocs/stopwatch/stopwatch_state.dart';
import 'package:chronometer/app/main/stopwatch/stopwatch_screen.dart';
import 'package:chronometer/app/main/models/index.dart';
import 'package:chronometer/app/main/shared/screen/theme_selector_screen.dart';
import 'package:chronometer/app/main/shared/utils/index.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  static const title = 'Chronometer';
  static final Map<String, Bloc> blocs = <String, Bloc>{};
  static final menu = <Menu>[
    Menu(1, 'Counter', <MenuOption>[
      MenuOption(1, 'Local'),
      MenuOption(2, 'Global', true),
    ]),
    Menu(2, 'Stopwatch', <MenuOption>[
      MenuOption(1, 'Local'),
      MenuOption(2, 'Global', true),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    blocs['Counter'] = BlocProvider.of<CounterBloc>(context);
    blocs['Stopwatch'] = BlocProvider.of<StopwatchBloc>(context);

    return (defaultTargetPlatform == TargetPlatform.iOS)
        ? _IOSMain(blocs: blocs, title: title, menu: menu)
        : _AndroidMain(blocs: blocs, title: title, menu: menu);
  }
}

class _IOSMain extends StatelessWidget {
  const _IOSMain(
      {super.key,
      required this.blocs,
      required this.title,
      required this.menu});
  final Map<String, Bloc> blocs;
  final String title;
  final List<Menu> menu;

  void _pushScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(CupertinoPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) => MultiBlocListener(
          listeners: [
            BlocListener<CounterBloc, int>(
                bloc: blocs['Counter'] as CounterBloc,
                listener: (context, state) {
                  if (state == 10) {
                    Timer? timer = Timer(const Duration(seconds: 1),
                        () => Navigator.of(context, rootNavigator: true).pop());

                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                              title: const Text('Counter Alert'),
                              content: Text('$state'),
                            )).then((value) {
                      timer?.cancel();
                      timer = null;
                    });
                  }
                }),
            BlocListener<StopwatchBloc, StopwatchState>(
              bloc: blocs['Stopwatch'] as StopwatchBloc?,
              listener: (context, state) => (state.time.inMilliseconds ==
                          10000 &&
                      !Navigator.of(context).canPop())
                  ? _pushScreen(context, const StopwatchScreenWithGlobalState())
                  : null,
            )
          ],
          child: CupertinoPageScaffold(
            child: CustomScrollView(
              slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  leading: Icon(CupertinoIcons.clock,
                      color: BuildTheme.getIOSIconColor(context)),
                  largeTitle: Text(title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20.0)),
                  trailing: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () =>
                        _pushScreen(context, const ThemeSelectorScreen()),
                    child: Icon(
                      CupertinoIcons.settings,
                      size: 32,
                      color: BuildTheme.getIOSIconColor(context),
                    ),
                  ),
                ),
                SliverFillRemaining(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ...menu.map((Menu item) => CupertinoListSection(
                          header: Text(item.name),
                          children: <CupertinoListTile>[
                            ...item.options.map((MenuOption option) =>
                                CupertinoListTile.notched(
                                  leading: item.name == 'Counter'
                                      ? Icon(CupertinoIcons.add_circled,
                                          color: BuildTheme.getIOSIconColor(
                                              context))
                                      : Icon(CupertinoIcons.timer,
                                          color: BuildTheme.getIOSIconColor(
                                              context)),
                                  title: Text(option.name),
                                  subtitle: item
                                      .buildBlocGlobal(option, blocs[item.name],
                                          (context, state) {
                                    Widget? widget;

                                    switch (item.name) {
                                      case 'Counter':
                                        widget = Text('$state');
                                        break;
                                      case 'Stopwatch':
                                        widget = Text('${state.timeFormated}');
                                        break;
                                    }

                                    return widget!;
                                  }),
                                  trailing: option.isGlobal == true
                                      ? Icon(CupertinoIcons.share_up,
                                          color: BuildTheme.getIOSIconColor(
                                              context))
                                      : Icon(
                                          CupertinoIcons.lock_circle,
                                          color: BuildTheme.getIOSIconColor(
                                              context),
                                        ),
                                  onTap: () {
                                    item.renderScreen(
                                        option,
                                        (Widget screen) =>
                                            _pushScreen(context, screen));
                                  },
                                ))
                          ],
                        )),
                  ],
                ))
              ],
            ),
          ));
}

class _AndroidMain extends StatelessWidget {
  const _AndroidMain(
      {super.key,
      required this.blocs,
      required this.title,
      required this.menu});
  final Map<String, Bloc> blocs;
  final String title;
  final List<Menu> menu;

  void _pushScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) => MultiBlocListener(
          listeners: [
            BlocListener<CounterBloc, int>(
                bloc: blocs['Counter'] as CounterBloc,
                listener: (context, state) => (state == 10)
                    ? showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              content: Text('Count: $state'),
                            ))
                    : null),
            BlocListener<StopwatchBloc, StopwatchState>(
              bloc: blocs['Stopwatch'] as StopwatchBloc?,
              listener: (context, state) => (state.time.inMilliseconds ==
                          10000 &&
                      !Navigator.of(context).canPop())
                  ? _pushScreen(context, const StopwatchScreenWithGlobalState())
                  : null,
            )
          ],
          child: Scaffold(
              appBar: AppBar(
                leading: const Icon(Icons.lock_clock),
                title: Text(title, textAlign: TextAlign.center),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.palette),
                    onPressed: () =>
                        _pushScreen(context, const ThemeSelectorScreen()),
                  )
                ],
              ),
              body: ListView(
                padding: const EdgeInsets.all(15.0),
                children: [
                  ...menu.map((Menu item) => Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                            child: Text(item.name, textAlign: TextAlign.start),
                          ),
                          ...item.options.map((MenuOption option) => ListTile(
                                leading: item.name == 'Counter'
                                    ? const Icon(Icons.add_circle_outline)
                                    : const Icon(Icons.timer),
                                title: Text(option.name),
                                subtitle: item.buildBlocGlobal(
                                    option, blocs[item.name], (context, state) {
                                  Widget? widget;

                                  switch (item.name) {
                                    case 'Counter':
                                      widget = Text('$state');
                                      break;
                                    case 'Stopwatch':
                                      widget = Text('${state.timeFormated}');
                                      break;
                                  }

                                  return widget!;
                                }),
                                trailing: option.isGlobal
                                    ? const Icon(Icons.lock_open)
                                    : const Icon(Icons.lock),
                                onTap: () {
                                  item.renderScreen(
                                      option,
                                      (Widget screen) =>
                                          _pushScreen(context, screen));
                                },
                                onLongPress: option.isGlobal == true
                                    ? () {
                                        switch (item.name) {
                                          case 'Counter':
                                            blocs[item.name]!
                                                .add(CounterEvent.increment);
                                            break;
                                          case 'Stopwatch':
                                            final stopwatchBloc =
                                                blocs[item.name]
                                                    as StopwatchBloc;

                                            blocs[item.name]!.add(
                                                stopwatchBloc.state.isRunning
                                                    ? StopStopwatch()
                                                    : StartStopwatch());
                                            break;
                                        }
                                      }
                                    : null,
                              ))
                        ],
                      ))
                ],
              )));
}
