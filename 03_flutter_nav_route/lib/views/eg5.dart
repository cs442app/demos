/* Topics demonstrated:
 * - Drawsers, Tabs, etc.
 */

import 'package:flutter/material.dart';
import 'package:flutter_nav_route/views/eg4.dart';
import 'package:provider/provider.dart';


class App5 extends StatelessWidget {
  const App5({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<MacGuffinCollection>(
        create: (context) => MacGuffinCollection(50),
        child: const AlltheThings()
      ),
    );  
  }
}


class AlltheThings extends StatefulWidget {
  const AlltheThings({super.key});

  @override
  State<AlltheThings> createState() => _AlltheThingsState();
}

class _AlltheThingsState extends State<AlltheThings> {
  int _selectedIndex = 0;

  void _changeSelection(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("All the things!"),
        ),
        drawer: MyDrawer(
          selected: _selectedIndex, 
          changeSelection: _changeSelection
        ),
        body: switch (_selectedIndex) {
          0 => TabbedPage(),
          1 => const MacGuffinsListPage(),
          _ => const SettingsPage(),
        }
    );
  }
}


class MyDrawer extends StatelessWidget {
  final int selected;
  final void Function(int index) changeSelection;

  const MyDrawer({
    required this.selected, required this.changeSelection,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              "Menu",
              textAlign: TextAlign.justify,
              textScaleFactor: 2.0,
            ),
          ),
          ListTile(
            title: const Text("Home"),
            selected: selected == 0,
            onTap: () {
              changeSelection(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("MacGuffins"),
            selected: selected == 1,
            onTap: () {
              changeSelection(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("Settings"),
            selected: selected == 2,
            onTap: () {
              changeSelection(2);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}


class TabbedPage extends StatelessWidget {
  TabbedPage({
    super.key,
  });

  final List<Tab> _tabs = [
    const Tab(icon: Icon(Icons.star)),
    const Tab(icon: Icon(Icons.favorite)),
    const Tab(icon: Icon(Icons.code)),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(tabs: _tabs),
        ),
        body: TabBarView(
          children: List.generate(_tabs.length, (index) {
            return Center(
              child: Consumer<MacGuffinCollection>(
                builder: (context, collection, _) {
                  return Text(collection[index].name,
                              style: const TextStyle(fontSize: 24.0));
                }
              )
            );
          })
        ),
      ),
    );
  }
}


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Settings",
        style: TextStyle(fontSize: 24.0),
      )
    );
  }
}
