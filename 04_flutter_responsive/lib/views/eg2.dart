/// Basic responsive layout with:
/// - a dynamic drawer/menu

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
    // get the size of the screen
    var media = MediaQuery.of(context).size;

    // only show the app bar and drawer if the screen is small
    var appBar = media.width < 600
        ? AppBar(
            title: Text(_menuItems[_selectedIndex]),
          )
        : null;

    var drawer = media.width < 600
        ? Drawer(
            child: Menu(
              items: _menuItems, 
              isDrawer: true,
              selectedIndex: _selectedIndex,
              onChange: _selectPage,
            )
          )
        : null;

    // show the menu if the screen is large
    var menu = media.width > 600 
        ? Expanded(
            flex: 1, 
            child: Menu(
              items: _menuItems, 
              selectedIndex: _selectedIndex,
              onChange: _selectPage,
            )
          ) 
        : Container();
    
    // build our responsive layout
    return Scaffold(
        appBar: appBar,
        drawer: drawer,
        body: Row(
          children: [
            menu,
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.lightBlueAccent,
                child: Center(
                  child: Text(
                    '${media.width} x ${media.height}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            )
          ],
        ),
    );
  }
}


/// A simple menu widget that can be used in a drawer or as a menu
class Menu extends StatelessWidget {
  final bool isDrawer;
  final List<String> items;
  final int? selectedIndex;
  final void Function(int)? onChange;

  const Menu({
    required this.items,
    this.selectedIndex, 
    isDrawer,
    this.onChange,
    super.key}
  ) : isDrawer = isDrawer ?? false;


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: items.map(
        (String item) {
          return ListTile(
            title: Text(item),
            selected: items.indexOf(item) == selectedIndex,
            onTap: () {
              if (isDrawer) Navigator.pop(context);

              // following is brittle, but works for this example
              if (onChange != null) onChange!(items.indexOf(item));
            },
          );
        },
      ).toList(),
    );
  }
}
