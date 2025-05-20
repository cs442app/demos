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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CpuHotspotBrokenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CPU Hotspot ‑ Broken',
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: const Text('CPU Hotspot ‑ Broken')),
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  final n = 200000;
                  final primes = countPrimesSync(
                    n,
                  ); // ❌ synchronous heavy compute
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Found $primes primes below $n')),
                  );
                },
                child: const Text('Count primes'),
              ),
            ),
          );
        },
      ),
    );
  }
}

int countPrimesSync(int max) {
  int count = 0;
  for (int i = 2; i < max; i++) {
    bool prime = true;
    for (int j = 2; j * j <= i; j++) {
      if (i % j == 0) {
        prime = false;
        break;
      }
    }
    if (prime) count++;
  }
  return count;
}

/*
 * CpuHotspotFixedApp
 * ------------------
 * Fix applied:
 *   • Offload prime counting to a separate isolate via `compute()`.
 * Expected result:
 *   • UI thread stays below 16 ms; isolate shows workload in CPU profiler.
 */
class CpuHotspotFixedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CPU Hotspot ‑ Fixed',
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: const Text('CPU Hotspot ‑ Fixed')),
            body: Center(
              child: ElevatedButton(
                onPressed: () async {
                  final n = 200000;
                  final primes = await compute(countPrimesSync, n);
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Found $primes primes below $n')),
                  );
                },
                child: const Text('Count primes (isolate)'),
              ),
            ),
          );
        },
      ),
    );
  }
}
