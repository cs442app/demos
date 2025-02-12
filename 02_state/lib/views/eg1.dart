/* Topics to demonstrate:
 * - Child widget managing its own state
 * - Stateful widgets & state objects
 * - `setState`
 * - `widget` property
 */

import 'package:flutter/material.dart';

class App1 extends StatelessWidget {
  const App1({super.key});

  @override
  Widget build(BuildContext context) {
    return const IncrementableCounter(increment: 1);
  }
}

// How do we make this stateful?
class IncrementableCounter extends StatelessWidget {
  final int increment;
  final int _counter = 0;

  const IncrementableCounter({super.key, required this.increment});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Counter: $_counter'),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => print("Increment counter by ${increment} here"),
          child: Text('+ ${increment}'), 
        ),
      ],
    );
  }
}
