/// Basic responsive layout with a dynamic drawer/menu, implemented using
/// information obtained via `MediaQuery`.

import 'package:flutter/material.dart';

class App3 extends StatefulWidget {
  const App3({super.key});

  @override
  State<App3> createState() => _App3State();
}

class _App3State extends State<App3> {
  int _selectedIndex = 0;
  final List<String> _menuItems = <String>['Home', 'About', 'Settings'];

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the size of the screen with a MediaQuery.
    var media = MediaQuery.of(context);

    // Note: accessing the MediaQuery object (via the InheritedWidget ".of"
    // mechanism) establishes a dependency on it, which will cause Flutter to 
    // rebuild the widget whenever any of the MediaQuery properties change.
    // It is more efficient to access specific MediaQuery properties through
    // methods like `sizeOf` and `orientationOf`.

    // only show the app bar and drawer if the screen is small
    var appBar = media.size.width < 600
        ? AppBar(
            title: Text(_menuItems[_selectedIndex]),
          )
        : null;

    var drawer = media.size.width < 600
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
    var menu = media.size.width > 600 
        ? Expanded(
            flex: 1, 
            child: Menu(
              items: _menuItems, 
              selectedIndex: _selectedIndex,
              onChange: _selectPage,
            )
          ) 
        : Container();
    
    // build our responsive layout (what happens at width = 600?)
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
                    '${media.size.width} x ${media.size.height}',
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
