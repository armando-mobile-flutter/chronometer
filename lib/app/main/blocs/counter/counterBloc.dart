import 'package:flutter_bloc/flutter_bloc.dart';

enum CounterEvent { increment, decrement, reset }

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc({int initialState = 0}) : super(initialState) {
    on<CounterEvent>(_onCounterEvent);
  }

  void _onCounterEvent(CounterEvent event, Emitter<int> emit) {
    switch (event) {
      case CounterEvent.increment:
        emit(state + 1);
        break;
      case CounterEvent.decrement:
        emit(state - 1);
        break;
      case CounterEvent.reset:
        emit(0);
        break;
    }
  }
}
