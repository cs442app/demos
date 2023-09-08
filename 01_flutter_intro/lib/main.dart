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
  const exampleNum = 2; // can we hot-reload a change to this?
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

    case 2:
      runApp(const App2());
      break;

    case 3:
      // our first Material app (what is Material? what does it provide?)
      // (check it out in the widget details tree)
      runApp(const MaterialApp(
        title: 'App3',
        home: App3() // the "home" / root widget
      ));
      break;

    case 4:
      runApp(const MaterialApp(
        title: 'App4',
        home: App4(),
      ));
      break;

    case 5:
      runApp(const MaterialApp(
        title: 'App5',
        home: App5(),
        debugShowCheckedModeBanner: false,
      ));
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

class App2 extends StatelessWidget {
  const App2({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      // the following property is inherited by descendant widgets
      textDirection: TextDirection.ltr,
      child: Column(
        // try to tweak this property in the layout explorer
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Hello!'), // no need to specify `textDirection` here
          const SizedBox(height: 50, width: 50), // spacer
          GestureDetector(
            child: const Text(
              'World!',
              style: TextStyle( // manually specified fancy style
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 30
              )
            ),
            // callback for when the widget is tapped
            onTap: () => print('"World!" clicked'),
          ),
        ]
      ),
    );
  }      
}

//*****************************************************************************

class App3 extends StatelessWidget {
  const App3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // what happens if we remove the scaffold?
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "I'm a Material App!",
              // where does this style come from?
              style: Theme.of(context).textTheme.titleLarge
            ),
            // automatic gesture detection
            // (try to find the GestureDetector in the widget details tree)
            ElevatedButton(
              child: const Text('Hey! Click me!'),
              onPressed: () {
                print('Button clicked');
              }, 
            )
          ],
        ),
      ),
    );
  }
}

//****************************************************************************

class App4 extends StatelessWidget {
  const App4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App4'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          print('Add button clicked');
        }, 
      ),
      body: ListView(
        // can you add the tiles 'Lions', 'Tigers', 'Bears', and 'Oh my!'?
        children: [
          ListTile(
            title: Text('Hello World!'),
            onTap: () => print('"Hello World!" clicked'),
          ),
        ]
      ),
    );
  }
}

//*****************************************************************************

// A stateful widget! Track down the superclass in the framework source code.
class App5 extends StatefulWidget {
  const App5({super.key});

  // note: we don't override `build` here
  @override
  State<App5> createState() => _App5State();
}


// A state object! The state persists across tree rebuilds, and is bound to
// its element in the tree. When the state changes, the widget is rebuilt.
class _App5State extends State<App5> {
  int _luckyNum = 0;

  _App5State() {
    _luckyNum = Random().nextInt(100);
  }

  void _generateLuckyNum() {
    // what happens if we remove the call to `setState`?
    setState(() {
      print('Generating lucky number...');
      _luckyNum = Random().nextInt(100);
    });
  }

  // try setting a breakpoint here and clicking the button
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lucky number generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Your lucky number is: $_luckyNum'),
            ElevatedButton(
              onPressed: _generateLuckyNum, 
              child: const Text('Get my lucky number'),
            )
          ],
        ),
      ),
    );
  }
}
