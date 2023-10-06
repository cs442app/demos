/// Demonstrates the use of a MediaQuery to access device and platform data.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;


class App3 extends StatelessWidget {
  const App3({super.key});

  @override
  Widget build(BuildContext context) {
    // Note: accessing the MediaQuery object (via the InheritedWidget ".of"
    // mechanism) establishes a dependency on it, which will cause Flutter to 
    // rebuild this widget whenever any of the MediaQuery properties change.
    // It is more efficient to access specific MediaQuery properties through
    // methods like `sizeOf` and `orientationOf`.
    var mq = MediaQuery.of(context);

    // Device and platform data
    var deviceData = <String, String>{
      'Dimensions': '${mq.size.width} x ${mq.size.height}',
      'Density': mq.devicePixelRatio.toString(),
      'Orientation': mq.orientation == Orientation.portrait 
                     ? 'Portrait' : 'Landscape',
      'Platform': kIsWeb ? 'Web' : Platform.operatingSystem,
      'Light/Dark Mode': mq.platformBrightness == Brightness.dark 
                         ? 'Dark Mode' : 'Light Mode',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Device and Platform Data'),
      ),
      body: ListView.builder(
        itemCount: deviceData.length,
        itemBuilder: (context, index) {
          final key = deviceData.keys.elementAt(index);
          final value = deviceData[key];
          return ListTile(
            title: Text(key),
            subtitle: Text(value.toString()),
          );
        },
      )
    );
  }
}
