/* Topics to demonstrate:
 * - Using the `provider` package to disseminate a ChangeNotifier
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

class App6 extends StatelessWidget {
  const App6({super.key});

  @override
  Widget build(BuildContext context) {
    // wrap the widget tree with the provider inherited widget
    return ChangeNotifierProvider(
      // model is created lazily (only when first accessed)
      create: (BuildContext context) => CountersModel(), 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SumDisplay(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (i) {
              return CounterDisplay(index: i);
            })
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (i) {
              return Incrementer(index: i, increment: i+1);
            })
          ),
        ],
      )
    );
  }
}


class CountersModel with ChangeNotifier, DiagnosticableTreeMixin{
  final Map<int,int> _counts = {};

  int get sum => _counts.values.sum;
  
  int getCount(int index) {
    return _counts[index] ?? 0;
  }

  void increment(int index, int inc) {
    _counts[index] = getCount(index) + inc;
    notifyListeners();
  }

  @override
  // this method is used by the Flutter Widget Inspector
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // expose map entries in widget details view
    properties.add(IterableProperty('counts', _counts.entries));
  }
}


class SumDisplay extends StatelessWidget {
  const SumDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    // rebuild whenever the model changes
    var counters = context.watch<CountersModel>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Sum: ${counters.sum}'),
    );
  }
}

class CounterDisplay extends StatelessWidget {
  final int index;

  const CounterDisplay({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    var val = context.select<CountersModel, int>((counters) {
      // rebuild only when the value at index changes
      return counters.getCount(index);
    });
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Counter: $val'),
    );
  }
}


class Incrementer extends StatelessWidget {
  final int index;
  final int? increment;

  const Incrementer({required this.index, this.increment, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          // `read` doesn't rebuild the widget when the model changes
          context.read<CountersModel>().increment(index, increment ?? 1);
        },
        child: Text('+${increment ?? 1}')
      ),
    );
  }
}
