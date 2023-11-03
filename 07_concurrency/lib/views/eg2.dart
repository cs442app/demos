import 'dart:async';
import 'package:flutter/material.dart';

class App2 extends StatefulWidget {
  const App2({Key? key}) : super(key: key);

  @override
  State<App2> createState() => _App2State();
}

class _App2State extends State<App2> {
  int counter = 0;
  int taskResult = 0;
  bool isTaskRunning = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    // start a timer that increments the counter every second
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() => counter++);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }


  // Use a timer-based delay to simulate a long-running task
  Future<void> longDelay(int n) async {
    await Future.delayed(Duration(seconds: n));
  }


  // Perform a CPU-intensive computation
  Future<int> longComputation(int n) async {
    int sum = 0;
    for (int i = 0; i < n; i++) {
      sum += i;
    }
    return sum;
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
                child: const Text('Reset')
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() => isTaskRunning = true);
                      isTaskRunning = true;
                      longDelay(3).then(
                        (_) => setState(() {
                          isTaskRunning = false;
                        })
                      );
                    },
                    child: const Text('Start delay (sync)')
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() => isTaskRunning = true);
                      await longDelay(3);
                      setState(() {
                        isTaskRunning = false;
                      });
                    },
                    child: const Text('Start delay (async)')
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() => isTaskRunning = true);
                      isTaskRunning = true;
                      longComputation(1000000000).then(
                        (value) => setState(() {
                          taskResult = value;
                          isTaskRunning = false;
                        })
                      );
                    },
                    child: const Text('Start compute (sync)')
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() => isTaskRunning = true);
                      var value = await longComputation(1000000000);
                      setState(() {
                        taskResult = value;
                        isTaskRunning = false;
                      });
                    },
                    child: const Text('Start compute (async)')
                  ),
                ],
              ),
            ],
          ),
        )
      )
    );
  }
}
