import 'dart:async';
import 'package:chronometer/app/main/blocs/stopwatch/stopwatch_event.dart';
import 'package:chronometer/app/main/blocs/stopwatch/stopwatch_state.dart';
import 'package:chronometer/app/main/shared/utils/build_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chronometer/app/main/blocs/stopwatch/stopwatch_bloc.dart';

class StopwatchScreenWithGlobalState extends StatelessWidget {
  const StopwatchScreenWithGlobalState({super.key});
  final String title = 'Stopwatch - Global State';

  @override
  Widget build(BuildContext context) =>
      defaultTargetPlatform == TargetPlatform.iOS
          ? _IOSStopwatchScreen(title: title)
          : _AndroidStopwatchScreen(title: title);
}

class StopwatchScreenWithLocalState extends StatelessWidget {
  final String title = 'Stopwatch - Local State';

  @override
  Widget build(BuildContext context) => BlocProvider<StopwatchBloc>(
      create: (context) => StopwatchBloc(),
      child: defaultTargetPlatform == TargetPlatform.iOS
          ? _IOSStopwatchScreen(title: title)
          : _AndroidStopwatchScreen(title: title));
}

class _IOSStopwatchScreen extends StatelessWidget {
  const _IOSStopwatchScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StopwatchBloc>(context);
    return CupertinoPageScaffold(
        child: BlocListener<StopwatchBloc, StopwatchState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.isSpecial) {
          Timer? timer = Timer(const Duration(seconds: 1),
              () => Navigator.of(context, rootNavigator: true).pop());

          showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoPopupSurface(
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 100,
                      child: Text(state.timeFormated),
                    ),
                  )).then((value) {
            timer?.cancel();
            timer = null;
          });
        }
      },
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
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20.0))),
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
                        builder: (BuildContext context, StopwatchState state) =>
                            Text(state.timeFormated,
                                style: const TextStyle(
                                    fontSize: 60, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 160.0),
                    Center(
                        child: BlocBuilder(
                      bloc: bloc,
                      buildWhen:
                          (StopwatchState previous, StopwatchState current) =>
                              previous.isInitial != current.isInitial ||
                              previous.isRunning != current.isRunning,
                      builder: (BuildContext context, StopwatchState state) =>
                          Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          if (state.isRunning)
                            CupertinoButton(
                                child: Icon(CupertinoIcons.stop,
                                    size: 50,
                                    color: BuildTheme.getIOSIconColor(context)),
                                onPressed: () => bloc.add(StopStopwatch()))
                          else
                            CupertinoButton(
                                child: Icon(CupertinoIcons.play_arrow,
                                    size: 50,
                                    color: BuildTheme.getIOSIconColor(context)),
                                onPressed: () => bloc.add(StartStopwatch())),
                          if (!state.isInitial)
                            CupertinoButton(
                                child: Icon(CupertinoIcons.restart,
                                    size: 50,
                                    color: BuildTheme.getIOSIconColor(context)),
                                onPressed: () => bloc.add(ResetStopwatch()))
                        ],
                      ),
                    ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class _AndroidStopwatchScreen extends StatelessWidget {
  const _AndroidStopwatchScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StopwatchBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: BlocListener<StopwatchBloc, StopwatchState>(
        bloc: bloc,
        listener: (BuildContext context, StopwatchState state) =>
            (state.isSpecial)
                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      state.timeFormated,
                    ),
                    duration: const Duration(seconds: 1),
                  ))
                : null,
        child: Center(
          child: BlocBuilder(
              bloc: bloc,
              builder: (BuildContext context, StopwatchState state) => Text(
                    state.timeFormated,
                    style: const TextStyle(
                        fontSize: 60, fontWeight: FontWeight.bold),
                  )),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder(
            bloc: bloc,
            buildWhen: (StopwatchState previous, StopwatchState current) =>
                previous.isInitial != current.isInitial ||
                previous.isRunning != current.isRunning,
            builder: (BuildContext context, StopwatchState state) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if (state.isRunning)
                      FloatingActionButton(
                          heroTag: null,
                          child: const Icon(Icons.stop),
                          onPressed: () => bloc.add(StopStopwatch()))
                    else
                      FloatingActionButton(
                          heroTag: null,
                          child: const Icon(Icons.play_arrow),
                          onPressed: () => bloc.add(StartStopwatch())),
                    if (!state.isInitial)
                      FloatingActionButton(
                          heroTag: null,
                          child: const Icon(Icons.replay),
                          onPressed: () => bloc.add(ResetStopwatch()))
                  ],
                )),
      ),
    );
  }
}
