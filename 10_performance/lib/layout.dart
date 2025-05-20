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

import 'package:flutter/material.dart';

class LayoutInefficiencyBrokenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layout ‑ Broken',
      home: Scaffold(
        appBar: AppBar(title: const Text('Layout Inefficiency ‑ Broken')),
        body: ListView.builder(
          itemCount: 500,
          itemBuilder: (c, i) {
            return IntrinsicHeight(
              // ❌ forces expensive layout
              child: IntrinsicWidth(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 60,
                      color: Colors.primaries[i % Colors.primaries.length],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Item $i ' * 5),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/*
 * LayoutInefficiencyFixedApp
 * --------------------------
 * Fix applied:
 *   • Remove Intrinsic* wrappers; use ListTile (one‑pass layout).
 * Expected result:
 *   • Layout events drop below the 16 ms budget; green frames.
 */
class LayoutInefficiencyFixedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layout ‑ Fixed',
      home: Scaffold(
        appBar: AppBar(title: const Text('Layout Inefficiency ‑ Fixed')),
        body: ListView.builder(
          itemCount: 500,
          itemBuilder:
              (c, i) => ListTile(
                leading: Container(
                  width: 40,
                  color: Colors.primaries[i % Colors.primaries.length],
                ),
                title: Text('Item $i'),
                subtitle: const Text('Using one‑pass ListTile layout'),
              ),
        ),
      ),
    );
  }
}
