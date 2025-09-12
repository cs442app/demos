/* Topics demonstrated:
 * - Running/Debugging a Flutter app
 * - Viewing Flutter framework source code
 * - Widget Inspector
 * - Some basic widgets: 
 *    - Placeholder
 *    - Text
 *    - Center
 *    - Column / Row
 *    - MaterialApp / CupertinoApp
 *    - Scaffold
 *    - AppBar
 *    - Icon
 *    - ListView / ListTile
 * - Custom widgets
 * - Hot reload
 */

// ignore_for_file: unused_import
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'views/eg.dart';

void main() {
  // 1. Simplest possible app
  runApp(const Placeholder());

  // 2. Hello world App
  runApp(Text('Hello world', textDirection: TextDirection.ltr));

  // 3. Wrapping in Center
  runApp(Center(child: Text('Hello world', textDirection: TextDirection.ltr)));

  // 4. Wrapping in Column layout
  runApp(Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text('Hello world', textDirection: TextDirection.ltr),
      Text('Hello world', textDirection: TextDirection.ltr),
      Text('Hello world', textDirection: TextDirection.ltr),
    ],
  ));

  // 5. Using (inherited) Directionality to avoid repeating textDirection
  runApp(Directionality(
    textDirection: TextDirection.ltr,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('Hello world'),
        Text('Hello world'),
        Text('Hello world'),
      ],
    ),
  ));

  // 6. Using MaterialApp and Scaffold to get Material Design
  runApp(MaterialApp(
    home: Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Hello world'),
          Text('Hello world'),
          Text('Hello world'),
        ],
      ),
    )),
  ));

  // 7. Fully fleshed out Scaffold
  runApp(
    MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('My First Material App')),
          floatingActionButton: FloatingActionButton(
              onPressed: null, child: const Icon(Icons.add)),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.home),
                Icon(Icons.business),
                Icon(Icons.school),
              ],
            ),
          ),
          drawer: Drawer(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Hello world'),
                TextButton(
                    onPressed: () => print('Button clicked'),
                    child: const Text('Click me')),
              ],
            ),
          )),
    ),
  );

  // 8. CupertinoApp-based Scaffold
  runApp(CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar:
          const CupertinoNavigationBar(middle: Text('My First Cupertino App')),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Hello world'),
            CupertinoButton(
                onPressed: () => print('Button clicked'),
                child: const Text('Click me')),
          ],
        ),
      ),
    ),
  ));

  // 9. Trying out a list view
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('My first List View')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Lions'),
            onTap: () => print('"Lions" clicked'),
          ),
          ListTile(
            title: const Text('Tigers'),
            onTap: () => print('"Tigers" clicked'),
          ),
          ListTile(
            title: const Text('Bears'),
            onTap: () => print('"Bears" clicked'),
          )
        ],
        // children: List.generate(100, (i) {
        //   return ListTile(
        //     title: Text('Item $i'),
        //     onTap: () => print('"Item $i" clicked'),
        //   );
        // }),
      ),
    ),
  ));

  // 10. Using custom widgets
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('My first List View')),
      body: MyList(),
    ),
  ));

  // 11. Prebuilt example in a separate file
  runApp(const MaterialApp(home: MyApp()));
}

class MyList extends StatelessWidget {
  const MyList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(100, (i) {
        return MyTile(index: i);
      }),
    );
  }
}

class MyTile extends StatelessWidget {
  const MyTile({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Item $index'),
      onTap: () => print('"Item $index" clicked'),
    );
  }
}
