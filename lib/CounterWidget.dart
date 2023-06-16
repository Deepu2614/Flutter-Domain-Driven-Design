import 'package:ddd1/Application/Counter/CounterState.dart';
import 'package:ddd1/Core/Counter/CounterEvents.dart';
import 'package:ddd1/Core/Counter/CounterStateValue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final counterProvider = StateNotifierProvider<CounterState, CounterStateValue>((ref) => CounterState());

class Counter extends ConsumerWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterState = ref.watch(counterProvider);
    final counterEvents = ref.watch(counterProvider.notifier);
    final textEditingController = TextEditingController();

    void initializeCounter() {
      final initialValue = int.tryParse(textEditingController.text) ?? 0;
      counterEvents.mapEventsToState(CounterEvents.initialize(initialValue));
      textEditingController.clear();
      FocusScope.of(context).requestFocus(FocusNode());
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
              title: const Text('DDD'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Text(
                            counterState.counter.toString(),
                            style: TextStyle(
                              fontSize: 60
                            ),
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(label: Text('Initialize a Number')),
                          controller: textEditingController,
                        ),
                        ElevatedButton(
                          onPressed: initializeCounter,
                          child: const Text('Initialize'),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              counterEvents.mapEventsToState(CounterEvents.increment());
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.white),
                            ),
                            icon: const Icon(Icons.plus_one),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              counterEvents.mapEventsToState(CounterEvents.decrement());
                            },
                            icon: const Icon(Icons.exposure_minus_1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
