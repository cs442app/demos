import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // For compute()

class App4 extends StatelessWidget {
  const App4({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isolate Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SortDemoWidget(),
    );
  }
}

class SortDemoWidget extends StatefulWidget {
  const SortDemoWidget({super.key});

  @override
  _SortDemoWidgetState createState() => _SortDemoWidgetState();
}

class _SortDemoWidgetState extends State<SortDemoWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _statusMessage = '';

  @override
  void initState() {
    super.initState();
    // Animation controller for a continuously rotating square.
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Simulates heavy computation on the main thread.
  void _sortWithoutIsolate() {
    setState(() {
      _statusMessage = 'Sorting on main isolate...';
    });
    // Create a large list with random integers.
    List<int> numbers =
        List.generate(1000000, (_) => Random().nextInt(1000000));
    // Sorting on the main isolate will block the UI and cause jank.
    numbers.sort();
    setState(() {
      _statusMessage = 'Main isolate sort complete.';
    });
  }

  // Offloads the heavy sorting work to an isolate using compute.
  Future<void> _sortWithIsolate() async {
    setState(() {
      _statusMessage = 'Sorting with isolate...';
    });
    List<int> numbers =
        List.generate(1000000, (_) => Random().nextInt(1000000));
    // The compute function takes the top-level function `sortList` and the list.
    numbers = await compute(sortList, numbers);
    setState(() {
      _statusMessage = 'Isolate sort complete.';
    });
  }

  // This top-level function is executed in an isolate.
  static List<int> sortList(List<int> numbers) {
    numbers.sort();
    return numbers;
  }

  @override
  Widget build(BuildContext context) {
    // This widget demonstrates UI jank with heavy computation on main isolate.
    return Scaffold(
      appBar: AppBar(title: const Text('Isolate vs. Main Isolate Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Animated rotating square.
            AnimatedBuilder(
              animation: _controller,
              child: Container(width: 100, height: 100, color: Colors.blue),
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * pi,
                  child: child,
                );
              },
            ),
            const SizedBox(height: 50),
            Text(_statusMessage),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sortWithoutIsolate,
              child: const Text('Sort without Isolate'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _sortWithIsolate,
              child: const Text('Sort with Isolate'),
            ),
          ],
        ),
      ),
    );
  }
}
