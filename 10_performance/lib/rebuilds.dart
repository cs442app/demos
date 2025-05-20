// Demonstration project for common Flutter performance issues.
// -----------------------------------------------------------------
// Each pair of widgets intentionally shows a single performance
// pathology (Broken) and then a corrected variant (Fixed).  Switch
// between them by changing the `runApp()` call in `main()`.
//
// 🛠 How to profile during the live demo
// ------------------------------------
// 1. Build & run the app in *profile* mode on a real device:
//      flutter run --profile
// 2. Open DevTools → Performance and record a trace (2–5 s).
// 3. Observe the described signal in the timeline / frame chart.
// 4. Replace `Broken` with `Fixed` in `main()` and repeat to
//    confirm the pathology disappears.
// -----------------------------------------------------------------

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExcessiveRebuildsBrokenApp extends StatefulWidget {
  @override
  _ExcessiveRebuildsBrokenAppState createState() =>
      _ExcessiveRebuildsBrokenAppState();
}

class _ExcessiveRebuildsBrokenAppState
    extends State<ExcessiveRebuildsBrokenApp> {
  late final Timer _timer;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 8), (_) {
      setState(() => _counter++); // ❌ rebuild whole tree at 60 fps
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebuilds ‑ Broken',
      home: Scaffold(
        appBar: AppBar(title: const Text('Excessive Rebuilds ‑ Broken')),
        body: Center(child: Text('Tick $_counter')), // entire app rebuilt
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

/*
 * ExcessiveRebuildsFixedApp
 * -------------------------
 * Fix applied:
 *   • Isolate mutable state to only the Text widget using ValueListenable.
 *   • Rest of tree becomes const widgets (zero rebuild cost).
 */
class ExcessiveRebuildsFixedApp extends StatelessWidget {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  ExcessiveRebuildsFixedApp({super.key}) {
    Timer.periodic(const Duration(milliseconds: 16), (_) => _counter.value++);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebuilds ‑ Fixed',
      home: Scaffold(
        appBar: AppBar(title: const Text('Excessive Rebuilds ‑ Fixed')),
        body: Center(
          child: ValueListenableBuilder<int>(
            valueListenable: _counter,
            builder: (_, v, __) => Text('Tick $v'),
          ),
        ),
      ),
    );
  }
}
