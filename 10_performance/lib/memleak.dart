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
import 'dart:math';
import 'package:flutter/material.dart';

class MemoryLeakBrokenApp extends StatefulWidget {
  @override
  _MemoryLeakBrokenAppState createState() => _MemoryLeakBrokenAppState();
}

class _MemoryLeakBrokenAppState extends State<MemoryLeakBrokenApp> {
  final List<String> _items = [];
  late final Timer _timer; // ❌ never canceled and holds State alive

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() => _items.add(Random().nextDouble().toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Leak ‑ Broken',
      home: Scaffold(
        appBar: AppBar(title: const Text('Memory Leak ‑ Broken')),
        body: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (_, i) => Text(_items[i]),
        ),
      ),
    );
  }
}

/*
 * MemoryLeakFixedApp
 * ------------------
 * Fix applied:
 *   • Cancel timer in dispose; impose max list size.
 * Expected result:
 *   • Heap stabilizes after GC; no unbounded growth.
 */
class MemoryLeakFixedApp extends StatefulWidget {
  @override
  _MemoryLeakFixedAppState createState() => _MemoryLeakFixedAppState();
}

class _MemoryLeakFixedAppState extends State<MemoryLeakFixedApp> {
  final List<String> _items = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {
        _items.insert(0, Random().nextDouble().toString());
        if (_items.length > 1000)
          _items.removeLast(); // prevent unbounded growth
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Leak ‑ Fixed',
      home: Scaffold(
        appBar: AppBar(title: const Text('Memory Leak ‑ Fixed')),
        body: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (_, i) => Text(_items[i]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
