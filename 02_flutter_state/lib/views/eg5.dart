/* Topics to demonstrate:
 * - A more complex model class (shared by multiple widgets)
 */

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class App5 extends StatefulWidget {
  const App5({super.key});

  @override
  State<App5> createState() => _App5State();
}

class _App5State extends State<App5> {
  final CountersModel _counters = CountersModel();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListenableBuilder(
          listenable: _counters, 
          builder: (BuildContext context, Widget? child) {
            return Column(
              children: [
                Text('Sum: ${_counters.sum}'),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(3, (i) {
                    return Text('Counter: ${_counters.getCount(i)}');
                  })
                ),
              ],
            );
          }
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Incrementer(
              label: '+1',
              onPressed: () => _counters.increment(0, 1)
            ),
            Incrementer(
              label: '+2',
              onPressed: () => _counters.increment(1, 2)
            ),
            Incrementer(
              label: '+3',
              onPressed: () => _counters.increment(2, 3)
            ),
          ],
        ),
      ],
    );
  }
}


class CountersModel with ChangeNotifier {
  final Map<int,int> _counts = {};

  int get sum => _counts.values.sum;
  
  int getCount(int index) {
    return _counts[index] ?? 0;
  }

  void increment(int index, int inc) {
    _counts[index] = getCount(index) + inc;
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
