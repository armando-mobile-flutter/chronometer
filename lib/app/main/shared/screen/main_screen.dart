import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chronometer/app/main/models/index.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  static const title = 'Chronometer';
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
  Widget build(BuildContext context) =>
      (defaultTargetPlatform == TargetPlatform.iOS)
          ? _IOSMain(title: title, menu: menu)
          : _AndroidMain(title: title, menu: menu);
}

class _IOSMain extends StatelessWidget {
  const _IOSMain({super.key, required this.title, required this.menu});
  final String title;
  final List<Menu> menu;

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              leading: const Icon(CupertinoIcons.clock),
              largeTitle: Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0)),
              trailing: CupertinoButton(
                child: const Icon(
                  CupertinoIcons.settings,
                  size: 32,
                ),
                padding: EdgeInsets.zero,
                onPressed: () {},
              ),
            ),
            SliverFillRemaining(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ...menu.map((Menu item) => CupertinoListSection(
                      header: Text(item.name),
                      children: <CupertinoListTile>[
                        ...item.options.map(
                            (MenuOption option) => CupertinoListTile.notched(
                                  leading: item.name == 'Counter'
                                      ? Icon(CupertinoIcons.add_circled)
                                      : Icon(CupertinoIcons.timer),
                                  title: Text(option.name),
                                  subtitle: const Text('0'),
                                  trailing: option.isGlobal
                                      ? Icon(CupertinoIcons.share_up)
                                      : Icon(CupertinoIcons.lock_circle),
                                  onTap: () {},
                                ))
                      ],
                    )),
              ],
            ))
          ],
        ),
      );
}

class _AndroidMain extends StatelessWidget {
  const _AndroidMain({super.key, required this.title, required this.menu});
  final String title;
  final List<Menu> menu;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.lock_clock),
        title: Text(title, textAlign: TextAlign.center),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.palette),
            onPressed: () => {},
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: [
          Container(
            height: 30,
            child: const Text('Counter', textAlign: TextAlign.start),
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Local'),
            subtitle: const Text('0'),
            trailing: const Icon(Icons.lock),
            onTap: () {},
            onLongPress: () {},
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Global'),
            subtitle: const Text('0'),
            trailing: const Icon(Icons.lock_open),
            onTap: () {},
            onLongPress: () {},
          ),
          Container(
            height: 30,
            child: const Text('Stopwatch', textAlign: TextAlign.start),
          ),
          ListTile(
            leading: const Icon(Icons.timer),
            title: const Text('Local'),
            subtitle: const Text('0'),
            trailing: const Icon(Icons.lock),
            onTap: () {},
            onLongPress: () {},
          ),
          ListTile(
            leading: const Icon(Icons.timer),
            title: const Text('Global'),
            subtitle: const Text('0'),
            trailing: const Icon(Icons.lock_open),
            onTap: () {},
            onLongPress: () {},
          )
        ],
      ));
}
