import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ddd1/Core/Counter/CounterEvents.dart';
import 'package:ddd1/Core/Counter/CounterStateValue.dart';

class CounterState extends StateNotifier<CounterStateValue> {
  CounterState() : super(CounterStateValue.initial());

  void mapEventsToState(CounterEvents events) {
    events.map(
      increment: (_) {
        state = state.copyWith(
          counter: state.counter + 1,
        );
      },
      decrement: (_) {
        state = state.copyWith(
          counter: state.counter - 1,
        );
      },
      initialize: (events) {
        state = state.copyWith(
          counter: events.value,
        );
      },
    );
  }
}
