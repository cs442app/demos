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
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [ 
        IncrementableCounter(increment: 1),
        // IncrementableCounter(increment: 2),
        // IncrementableCounter(increment: 3),
      ],
    );
  }
}


// Even though it is "stateful", it is immutable! Its mutable state is
// contained in its associated state object. Be sure you understand the 
// relationship between the widget, its element, and its state object.
class IncrementableCounter extends StatefulWidget {
  final int increment;

  const IncrementableCounter({required this.increment, super.key});

  @override
  State<IncrementableCounter> createState() => _IncrementableCounterState();
}


// The state object is only constructed once, when the widget is first created.
class _IncrementableCounterState extends State<IncrementableCounter> {
  // mutable state
  int _counter = 0;

  void _incrementCounter() {
    setState(() { // what happens if we don't call `setState`?
      // we can use `widget` to access our associated widget's properties
      _counter += widget.increment;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Counter: $_counter'),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _incrementCounter, // callback to mutate state
          child: Text('+ ${widget.increment}'), 
        ),
      ],
    );
  }
}
