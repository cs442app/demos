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
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:performance/cpu_hotspot.dart';
import 'package:performance/images.dart';
import 'package:performance/layout.dart';
import 'package:performance/memleak.dart';
import 'package:performance/rebuilds.dart';

void main() {
  // 🔄 Change which app runs here
  // runApp(LayoutInefficiencyBrokenApp());
  // runApp(LayoutInefficiencyFixedApp());
  // runApp(ImageDecodeBrokenApp());
  // runApp(ImageDecodeFixedApp());
  // runApp(ExcessiveRebuildsBrokenApp());
  // runApp(ExcessiveRebuildsFixedApp());
  // runApp(CpuHotspotBrokenApp());
  // runApp(CpuHotspotFixedApp());
  // runApp(MemoryLeakBrokenApp());
  runApp(MemoryLeakFixedApp());
}
