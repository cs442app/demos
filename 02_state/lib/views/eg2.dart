/* Topics to demonstrate:
 * - Parent widget managing simple state
 * - Setting up mutating callbacks
 */

import 'package:flutter/material.dart';

class App2 extends StatefulWidget {
  const App2({super.key});

  @override
  State<App2> createState() => _App2State();
}

class _App2State extends State<App2> {
  int _counter = 0;

  void _incrementCounter(int inc) {
    setState(() {
      _counter += inc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      CounterDisplay(_counter),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Incrementer(label: '+1', onPressed: () => _incrementCounter(1)),
        Incrementer(label: '+2', onPressed: () => _incrementCounter(2)),
        Incrementer(label: '+3', onPressed: () => _incrementCounter(3))
      ])
    ]);
  }
}

class CounterDisplay extends StatelessWidget {
  final int val;

  const CounterDisplay(this.val, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Counter: $val'),
    );
  }
}

class Incrementer extends StatelessWidget {
  final String? label;
  final VoidCallback? onPressed;

  const Incrementer({this.label, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: onPressed, child: Text(label ?? 'Increment')),
    );
  }
}
