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
 *    - ListView and ListTile
 *    - MaterialApp
 *    - Placeholder
 *    - Row
 *    - SizedBox
 *    - Scaffold
 *    - Text
 * - Inherited widgets
 * - Stateless widgets
 */

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

class FavoriteItem {
  final String name;
  final String description;
  final String imagePath;

  const FavoriteItem({
    required this.name,
    required this.description,
    required this.imagePath,
  });
}


class App5 extends StatelessWidget {
  const App5({super.key});

  @override
  Widget build(BuildContext context) {
    const foods = {
      FavoriteItem(
        name: 'Pizza',
        description: 'A delicious pie of cheese and sauce',
        imagePath: 'assets/images/pizza.jpg'
      ),
      FavoriteItem(
        name: 'Burger',
        description: 'A juicy burger with all the fixings',
        imagePath: 'assets/images/burger.jpg'
      ),
      FavoriteItem(
        name: 'Ice Cream',
        description: 'A sweet treat to cool you down',
        imagePath: 'assets/images/ice_cream.jpg'
      ),
    };

    const languages = {
      FavoriteItem(
        name: 'Haskell',
        description: 'A purely functional programming language',
        imagePath: 'assets/images/haskell.png'
      ),
      FavoriteItem(
        name: 'Lisp',
        description: 'Lots of irritating superfluous parentheses',
        imagePath: 'assets/images/lisp.png'
      ),
      FavoriteItem(
        name: 'Rust',
        description: 'A systems programming language',
        imagePath: 'assets/images/rust.png'
      ),
    };

    // can you spot the nested `Row` and `Column` widgets?
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorite Things'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Foods', 
            style: Theme.of(context).textTheme.headlineLarge
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: foods.map((item) => FavoriteWidget(item: item)).toList(),
          ),
          const SizedBox(height: 30),
          Text(
            'Languages', 
            style: Theme.of(context).textTheme.headlineLarge
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: languages.map((item) => FavoriteWidget(item: item)).toList(),
          ),
        ],
      )
     );
  }
}


class FavoriteWidget extends StatelessWidget {
  final FavoriteItem item;

  const FavoriteWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          GestureDetector(
            child: Image.asset(
              item.imagePath,
              width: 100,
              height: 100,
            ),
            onTap: () => _showSnackBar(context, item.description)
          ),
          const SizedBox(height: 8),
          Text(
            item.name,
            style: Theme.of(context).textTheme.titleLarge,
          )
        ],
      ),
    );
  }

  // a "Snackbar" is a Material widget that appears at the bottom of the screen
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 500),
      )
    );
  }
}
