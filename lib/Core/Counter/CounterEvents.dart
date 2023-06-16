import 'package:freezed_annotation/freezed_annotation.dart';

part 'CounterEvents.freezed.dart';

@freezed
class CounterEvents with _$CounterEvents {
  const factory CounterEvents.increment() = Increment;
  const factory CounterEvents.decrement() = Decrement;
  const factory CounterEvents.initialize(int value) = Initialize;
}
