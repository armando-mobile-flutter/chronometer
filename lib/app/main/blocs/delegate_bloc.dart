import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocDelegate extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);

    if (kDebugMode) {
      print('onCreate ===> ${bloc.runtimeType}');
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);

    if (kDebugMode) {
      print('onEvent ===> bloc: ${bloc.runtimeType}, event: $event');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    if (kDebugMode) {
      print('onChange ===> bloc: ${bloc.runtimeType}, change: $change');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    if (kDebugMode) {
      print(
          'onTransition ===> bloc: ${bloc.runtimeType}, transition: $transition');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);

    if (kDebugMode) {
      print(
          'onError ===> bloc: ${bloc.runtimeType}, error: $error, stackTrace: $stackTrace');
    }
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);

    if (kDebugMode) {
      print('onClose ===> bloc: ${bloc.runtimeType}');
    }
  }
}
