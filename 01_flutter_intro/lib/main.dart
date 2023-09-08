/* Topics demonstrated:
 * - Running/Debugging a Flutter app
 * - Viewing Flutter framework source code
 * - Widget Inspector
 * - Hot reload & limitations
 * - Material Design
 * - Some basic widgets: 
 *    - AppBar
 *    - Center
 *    - Column
 *    - ElevatedButton
 *    - GestureDetector
 *    - Icon
 *    - ListView (and ListTile)
 *    - MaterialApp
 *    - Placeholder
 *    - SizedBox
 *    - Scaffold
 *    - Text
 * - Inherited widgets
 * - Stateless widgets
 * - Stateful widgets
 */

import 'dart:math';
import 'package:flutter/Material.dart';

void main() {
  const exampleNum = 1; // can we hot-reload a change to this?
                        // see https://docs.flutter.dev/tools/hot-reload#special-cases

  switch(exampleNum) {
    case 0:
      // simplest possible app!
      // (check out definitions of `runApp`, `Placeholder`, and superclasses)
      runApp(const Placeholder());
      break;

    case 1:
      // a custom widget
      runApp(const App1()); // why the `const`?
      break;
  }
}

//*****************************************************************************

class App1 extends StatelessWidget {
  // why is this constructor `const`? (what happens if we remove it?)
  // note the unused optional parameter `key` (we'll talk about this later)
  const App1({super.key});

  // `build` is called by the framework to build the widget tree
  @override
  Widget build(BuildContext context) {  // `context` is my location in the tree
    // construct and return a widget tree
    // (try to navigate the tree in the widget inspector)
    return const Center(
      child: Text(
        'Hello world!', // try changing this and hot-reloading
        textDirection: TextDirection.ltr, // what happens if we remove this?
      )
    );
  }      
}

//*****************************************************************************
