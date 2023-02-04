import 'package:chronometer/app/main/blocs/counter/counterBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:chronometer/app/main/shared/utils/build_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CouterScreenWithGlobalState extends StatelessWidget {
  const CouterScreenWithGlobalState({super.key});
  final String title = 'Counter - Global State';

  @override
  Widget build(BuildContext context) =>
      defaultTargetPlatform == TargetPlatform.iOS
          ? _IOSCounterScreen(title: title)
          : _AndroidCounterScreen(title: title);
}

class CouterScreenWithLocalState extends StatelessWidget {
  final String title = 'Counter - Local State';

  @override
  Widget build(BuildContext context) => BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
      child: defaultTargetPlatform == TargetPlatform.iOS
          ? _IOSCounterScreen(title: title)
          : _AndroidCounterScreen(title: title));
}

class _IOSCounterScreen extends StatelessWidget {
  const _IOSCounterScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CounterBloc>(context);

    return CupertinoPageScaffold(
        child: CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
            leading: CupertinoButton(
              child: Icon(CupertinoIcons.back,
                  size: 32, color: BuildTheme.getIOSIconColor(context)),
              padding: EdgeInsets.zero,
              onPressed: () => Navigator.pop(context),
            ),
            largeTitle: Text(title,
                textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0))),
        SliverFillRemaining(
            child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: BlocBuilder(
                  bloc: bloc,
                  builder: (context, state) => Text(
                    '$state',
                    style: const TextStyle(
                        fontSize: 100, fontWeight: FontWeight.bold),
                  ),
                )),
                const SizedBox(height: 160.0),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CupertinoButton(
                        child: Icon(CupertinoIcons.add,
                            size: 50,
                            color: BuildTheme.getIOSIconColor(context)),
                        onPressed: () => bloc.add(CounterEvent.increment),
                      ),
                      CupertinoButton(
                        child: Icon(CupertinoIcons.minus,
                            size: 50,
                            color: BuildTheme.getIOSIconColor(context)),
                        onPressed: () => bloc.add(CounterEvent.decrement),
                      ),
                      CupertinoButton(
                        child: Icon(CupertinoIcons.restart,
                            size: 50,
                            color: BuildTheme.getIOSIconColor(context)),
                        onPressed: () => bloc.add(CounterEvent.reset),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ))
      ],
    ));
  }
}

class _AndroidCounterScreen extends StatelessWidget {
  const _AndroidCounterScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) => Text('$state',
                style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold)),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                heroTag: null,
                child: const Icon(Icons.add),
                onPressed: () => bloc.add(CounterEvent.increment),
              ),
              FloatingActionButton(
                heroTag: null,
                child: const Icon(Icons.remove),
                onPressed: () => bloc.add(CounterEvent.decrement),
              ),
              FloatingActionButton(
                heroTag: null,
                child: const Icon(Icons.replay),
                onPressed: () => bloc.add(CounterEvent.reset),
              )
            ],
          ),
        ));
  }
}
