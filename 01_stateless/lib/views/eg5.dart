/* Demonstrating a ListView -- a very flexible widget */

import 'package:flutter/Material.dart';

class App5 extends StatelessWidget {
  const App5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My first list app'),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => print('Add button clicked')),
      body: ListView(
          // can you add the tiles 'Lions', 'Tigers', 'Bears', and 'Oh my!'?
          children: [
            ListTile(
              title: const Text('Hello World!'),
              onTap: () => print('"Hello World!" clicked'),
            ),
          ]),
    );
  }
}
