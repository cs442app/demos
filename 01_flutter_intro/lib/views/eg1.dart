/* Super-simple widget */

import 'package:flutter/Material.dart';

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
