import 'dart:async';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class App3 extends StatefulWidget {
  const App3({Key? key}) : super(key: key);

  @override
  State<App3> createState() => _App3State();
}

// Only top-level or static functions can be invoked from an isolate
Future<int> longComputation(int n) async {
  int sum = 0;
  for (int i = 0; i < n; i++) {
    sum += i;
  }
  return sum;
}

class _App3State extends State<App3> {
  int counter = 0;
  int taskResult = 0;
  bool isTaskRunning = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() => counter++);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> startLongComputation() async {
    setState(() {
      isTaskRunning = true;
    });

    // Use either Isolate.run or compute to run a function in a separate isolate
    int result = await Isolate.run(() => longComputation(1000000000));
    // int result = await compute(longComputation, 1000000000);

    setState(() {
      taskResult = result;
      isTaskRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Counter: $counter'),
              const SizedBox(height: 20),
              Text('Task running: $isTaskRunning'),
              const SizedBox(height: 20),
              Text('Task result: $taskResult'),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () => setState(() {
                        counter = 0;
                        taskResult = 0;
                      }),
                  child: const Text('Reset')),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() => isTaskRunning = true);
                        isTaskRunning = true;
                        startLongComputation().then((value) => setState(() {
                              isTaskRunning = false;
                            }));
                      },
                      child: const Text('Start isolate (sync)')),
                  ElevatedButton(
                      onPressed: () => startLongComputation(),
                      child: const Text('Start isolate (async)')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
