/* Topics to demonstrate:
 * - Extracting state into a model class
 * - ChangeNotifier, Listenable, and ListenableBuilder
 */

import 'package:flutter/material.dart';

// Why must we use a `StatefulWidget` here? (`setState` isn't used!)
class App4 extends StatefulWidget {
  const App4({super.key});

  @override
  State<App4> createState() => _App4State();
}

class _App4State extends State<App4> {
  final CounterModel _counter = CounterModel();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // A `ListenableBuilder` is paired with a `Listenable` object 
        // (like a `ChangeNotifier`) and rebuilds its subtree whenever 
        // the `Listenable` sends notification of a change
        ListenableBuilder(
          listenable: _counter, 
          builder: (BuildContext context, Widget? child) {
            return Text('Counter: ${_counter.count}');
          }
        ),
        Incrementer(
          onPressed: () => _counter.increment(1)
        ),

      ],
    );
  }
}


// Our data model is a `ChangeNotifier`, which will notify its listeners
// whenever it is updated
class CounterModel with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment(int inc) {
    _count += inc;
    notifyListeners();
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
        child: Text(label ?? '++')
      ),
    );
  }
}
