import 'package:flutter_bloc/flutter_bloc.dart';

enum CounterEvent { increment, decrement, reset }

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc({int initialState = 0}) : super(initialState) {
    on<CounterEvent>((event, emit) {
      switch (event) {
        case CounterEvent.increment:
          return emit(state + 1);
        case CounterEvent.decrement:
          return emit(state - 1);
        case CounterEvent.reset:
          return emit(0);
      }
    });
  }
}
