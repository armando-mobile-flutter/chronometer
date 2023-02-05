import 'package:chronometer/app/main/blocs/stopwatch/stopwatch_event.dart';
import 'package:chronometer/app/main/blocs/stopwatch/stopwatch_state.dart';
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
  _IOSStopwatchScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StopwatchBloc>(context);
    return CupertinoPageScaffold(child: Text('Hola'));
  }
}

class _AndroidStopwatchScreen extends StatelessWidget {
  _AndroidStopwatchScreen({super.key, required this.title});
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
        padding: EdgeInsets.all(16),
        child: BlocBuilder(
            bloc: bloc,
            buildWhen:
                (StopwatchState previousState, StopwatchState currentState) =>
                    previousState.isInitial != currentState.isInitial ||
                    previousState.isRunning != currentState.isRunning,
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
