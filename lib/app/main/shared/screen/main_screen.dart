import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  static const title = 'Chronometer';

  @override
  Widget build(BuildContext context) =>
      (defaultTargetPlatform == TargetPlatform.iOS)
          ? const _IOSMain(title: title)
          : const _AndroidMain(title: title);
}

class _IOSMain extends StatelessWidget {
  const _IOSMain({super.key, required this.title});
  final String title;

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
                CupertinoListSection(
                  header: Text('Counter'),
                  children: <CupertinoListTile>[
                    CupertinoListTile.notched(
                      leading: Icon(CupertinoIcons.add_circled),
                      title: const Text('Local'),
                      subtitle: const Text('0'),
                      trailing: Icon(CupertinoIcons.lock_circle),
                      onTap: () {},
                    ),
                    CupertinoListTile.notched(
                      leading: Icon(CupertinoIcons.add_circled),
                      title: const Text('Global'),
                      subtitle: const Text('0'),
                      trailing: Icon(CupertinoIcons.share_up),
                      onTap: () {},
                    )
                  ],
                ),
                CupertinoListSection(
                  header: Text('Stopwatch'),
                  children: <CupertinoListTile>[
                    CupertinoListTile.notched(
                      leading: Icon(CupertinoIcons.timer),
                      title: const Text('Local'),
                      subtitle: const Text('0'),
                      trailing: Icon(CupertinoIcons.lock_circle),
                      onTap: () {},
                    ),
                    CupertinoListTile.notched(
                      leading: Icon(CupertinoIcons.timer),
                      title: const Text('Global'),
                      subtitle: const Text('0'),
                      trailing: Icon(CupertinoIcons.share_up),
                      onTap: () {},
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      );
}

class _AndroidMain extends StatelessWidget {
  const _AndroidMain({super.key, required this.title});
  final String title;

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
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Counter',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          ListView(
            children: [
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
            ],
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Stopwatch',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          ListView(
            children: [
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
              ),
            ],
          )
        ],
      ));
}
