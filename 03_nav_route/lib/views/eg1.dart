/* Topics demonstrated:
 * - Simple back-and-forth navigation between two pages
 */

import 'package:flutter/material.dart';

class App1 extends StatelessWidget {
  const App1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'App 1',
      // the home widget is the first page, or "route", to display --
      // it is at the bottom of the navigation stack
      home: Page1(),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Page 1')),
        body: Center(
          child: TextButton(
            child: const Text('Go to Page 2'),
            onPressed: () {
              // Navigate to Page2
            },
          ),
        ));
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Page 2')),
        body: Center(
          // This button isn't really needed, since the AppBar
          // automatically provides a "back" button
          child: TextButton(
            child: const Text('Go back to Page 1'),
            onPressed: () {
              // Navigate back to Page1
            },
          ),
        ));
  }
}
