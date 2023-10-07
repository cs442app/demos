/* Our first Material app! */

import 'package:flutter/Material.dart';

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
              // where does this style come from? how is it retrieved?
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
