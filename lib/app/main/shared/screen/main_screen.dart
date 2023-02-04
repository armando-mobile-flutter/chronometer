import 'package:chronometer/app/main/blocs/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chronometer/app/main/models/index.dart';
import 'package:chronometer/app/main/shared/screen/theme_selector_screen.dart';
import 'package:chronometer/app/main/shared/utils/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    //TODO: Create variable for each bloc
    blocs['Counter'] = BlocProvider.of<CounterBloc>(context);

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
            BlocListener(
                bloc: blocs['Counter'],
                listener: (context, state) => (state == 10)
                    ? showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              content: Text('Count: $state'),
                            ))
                    : null)
          ],
          child: CupertinoPageScaffold(
            child: CustomScrollView(
              slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  leading: Icon(CupertinoIcons.clock,
                      color: BuildTheme.getIOSIconColor(context)),
                  largeTitle: Text(title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0)),
                  trailing: CupertinoButton(
                    child: Icon(
                      CupertinoIcons.settings,
                      size: 32,
                      color: BuildTheme.getIOSIconColor(context),
                    ),
                    padding: EdgeInsets.zero,
                    onPressed: () =>
                        _pushScreen(context, const ThemeSelectorScreen()),
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
                                  subtitle: item.buildBlocGlobal(
                                      option,
                                      blocs[item.name],
                                      (context, state) => Text('$state')),
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
            BlocListener(
                bloc: blocs['Counter'],
                listener: (context, state) => (state == 10)
                    ? showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              content: Text('Count: $state'),
                            ))
                    : null)
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
                          Container(
                            height: 30,
                            child: Text(item.name, textAlign: TextAlign.start),
                          ),
                          ...item.options.map((MenuOption option) => ListTile(
                                leading: item.name == 'Counter'
                                    ? Icon(Icons.add_circle_outline)
                                    : Icon(Icons.timer),
                                title: Text(option.name),
                                subtitle: item.buildBlocGlobal(
                                    option,
                                    blocs[item.name],
                                    (context, state) => Text('$state')),
                                trailing: option.isGlobal
                                    ? Icon(Icons.lock_open)
                                    : Icon(Icons.lock),
                                onTap: () {
                                  item.renderScreen(
                                      option,
                                      (Widget screen) =>
                                          _pushScreen(context, screen));
                                },
                                onLongPress: option.isGlobal == true
                                    ? () {
                                        if (item.name == 'Counter') {
                                          blocs[item.name]!
                                              .add(CounterEvent.increment);
                                        }
                                      }
                                    : null,
                              ))
                        ],
                      ))
                ],
              )));
}
