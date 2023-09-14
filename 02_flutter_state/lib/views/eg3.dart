/* Topics to demonstrate:
 * - Parent widget managing state for multiple children
 */

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class App3 extends StatefulWidget {
  const App3({super.key});

  @override
  State<App3> createState() => _App3State();
}

class _App3State extends State<App3> {
  final List<int> _counters = [0, 0, 0];

  void _incrementCounter(int index, int inc) {
    setState(() {
      _counters[index] += inc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Sum: ${_counters.sum}'),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: 
            List.generate(_counters.length, (i) {
              return Column(
                children: [
                  CounterDisplay(_counters[i]),
                  Incrementer(
                    label: '+${i+1}', 
                    // this callback decouples the child from our implementation
                    onPressed: () => _incrementCounter(i, i+1)
                  ),
                ]
              );
            })
        )
      ]
    );
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
        onPressed: onPressed,
        child: Text(label ?? 'Increment')
      ),
    );
  }
}
