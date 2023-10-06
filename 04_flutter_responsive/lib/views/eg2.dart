/// Example of a non-responsive app built using `flex` where:
/// - the menu is always visible
/// - the content area is always 3/4 of the screen width

import 'package:flutter/material.dart';


class App2 extends StatefulWidget {
  const App2({super.key});

  @override
  State<App2> createState() => _App2State();
}

class _App2State extends State<App2> {
  int _selectedIndex = 0;
  final List<String> _menuItems = <String>['Home', 'About', 'Settings'];

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {      
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1, // 1/4 of the screen width
            child: Menu(
              items: _menuItems, 
              selectedIndex: _selectedIndex,
              onChange: _selectPage,
            ),
          ),
          Expanded(
            flex: 3, // 3/4 of the screen width
            child: Container(
              color: Colors.lightBlueAccent,
              child: Center(
                child: Text(
                  _menuItems[_selectedIndex],
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}


class Menu extends StatelessWidget {
  final List<String> items;
  final int? selectedIndex;
  final void Function(int)? onChange;

  const Menu({
    required this.items,
    this.selectedIndex, 
    this.onChange,
    super.key}
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: items.map(
        (String item) {
          return ListTile(
            title: Text(item),
            selected: items.indexOf(item) == selectedIndex,
            onTap: () {
              if (onChange != null) onChange!(items.indexOf(item));
            },
          );
        },
      ).toList(),
    );
  }
}
