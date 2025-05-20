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
import 'package:flutter/material.dart';

const _largeImageUrl =
    'https://upload.wikimedia.org/wikipedia/commons/3/3f/Fronalpstock_big.jpg'; // ~8 K×5 K

/*
 * ImageDecodeBrokenApp
 * --------------------
 * DevTools symptom:
 *   • "Image (decode)" events on UI thread; raster time spikes.
 * How to spot:
 *   • Record a trace, scroll; notice decode events aligned with jank.
 */
class ImageDecodeBrokenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Decode ‑ Broken',
      home: Scaffold(
        appBar: AppBar(title: const Text('Image Decode ‑ Broken')),
        body: ListView.builder(
          itemCount: 30,
          itemBuilder:
              (c, i) => Image.network(
                _largeImageUrl,
              ), // ❌ decodes full‑res every time
        ),
      ),
    );
  }
}

/*
 * ImageDecodeFixedApp
 * -------------------
 * Fix applied:
 *   • Pre‑cache the image once; use ColorFiltered placeholders while loading.
 *   • Supply cacheWidth/cacheHeight so engine downsamples off‑thread.
 * Expected result:
 *   • No decode events on UI thread; smooth scrolling.
 */
class ImageDecodeFixedApp extends StatelessWidget {
  final _downsampled = _largeImageUrl;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _warmUp(context),
      builder: (c, s) {
        if (s.connectionState != ConnectionState.done) {
          return const MaterialApp(
            home: Center(child: CircularProgressIndicator()),
          );
        }
        return MaterialApp(
          title: 'Image Decode ‑ Fixed',
          home: Scaffold(
            appBar: AppBar(title: const Text('Image Decode ‑ Fixed')),
            body: ListView.builder(
              itemCount: 30,
              itemBuilder:
                  (c, i) => Image.network(
                    _downsampled,
                    cacheWidth: 800,
                    cacheHeight: 500,
                    fit: BoxFit.cover,
                  ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _warmUp(BuildContext context) async {
    await precacheImage(NetworkImage(_largeImageUrl), context);
  }
}
