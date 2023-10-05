/// An app that implements the standard drill-down menu pattern, but
/// adapts to the screen size by using different layouts. We use a
/// `LayoutBuilder` to rebuild widgets when the screen size changes.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/macguffin.dart';


class App4 extends StatelessWidget {
  const App4({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MacGuffinCollection(50),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            return const SingleLayout();
          } else {
            return const DoubleLayout();
          }
        }
      )
    );
  }
}


// A narrow-screen layout that uses the navigation stack to show the list and
// detail views on different pages.
class SingleLayout extends StatelessWidget {
  const SingleLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var macguffins = Provider.of<MacGuffinCollection>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('MacGuffins')),
      body: MacGuffinsListPage(
        onTapped: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => 
                ChangeNotifierProvider<MacGuffinCollection>.value(
                  value: macguffins,
                  child: Scaffold(
                    appBar: AppBar(title: const Text('Details')),
                    body: const MacGuffinDetailPage()
                  )
              )
            )
          );

          macguffins.selectedIndex = null;
        }
      ),
    );
  }
}


// A wide-screen layout that uses a row to show the list and detail views
// side-by-side.
class DoubleLayout extends StatelessWidget {
  const DoubleLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Row(
        children: [
          const Expanded(
            flex: 1, // 1/4 of the screen width
            child: MacGuffinsListPage(highlightSelected: true),
          ),
          Expanded(
            flex: 3, // 3/4 of the screen width
            child: Consumer<MacGuffinCollection>(
              builder: (context, macGuffins, child) =>
                const MacGuffinDetailPage()
            ),
          ),
        ],
      )
    );
  }
}


// A widget that shows a list of MacGuffins, which can be used in both the
// single and double layouts.
class MacGuffinsListPage extends StatelessWidget {
  final VoidCallback? onTapped;
  final bool highlightSelected;

  const MacGuffinsListPage({
    this.onTapped, 
    this.highlightSelected = false,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MacGuffinCollection>(
      builder: (context, macGuffins, child) => ListView.builder(
        itemCount: macGuffins.length,
        itemBuilder: (context, index) => Container(
          color: highlightSelected && macGuffins.selectedIndex == index
            ? Colors.lightBlueAccent
            : null,
          child: ListTile(
            title: Text(macGuffins[index].name),
            onTap: () {
              macGuffins.selectedIndex = index;
              if (onTapped != null) onTapped!();
            },
          ),
        )
      )
    );
  }
}


// A widget that shows the details of a selected MacGuffin, which can be used
// in both the single and double layouts.
class MacGuffinDetailPage extends StatelessWidget {
  const MacGuffinDetailPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<MacGuffinCollection>(
      builder:(context, macguffins, child) {
        var macguffin = macguffins.selectedIndex != null
          ? macguffins[macguffins.selectedIndex!]
          : null;

        if (macguffin == null) {
          return Center(
            child: Text(
              'No MacGuffin selected',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        } else {
          var formatter = NumberFormat.currency(locale: 'en_US', symbol: '\$');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  macguffin.name, 
                  style: Theme.of(context).textTheme.titleLarge
                ),
                const SizedBox(height: 20),
                Text(
                  formatter.format(macguffin.price),
                  style: Theme.of(context).textTheme.titleLarge
                ),
                const SizedBox(height: 20),
                Text(macguffin.description),
              ],
            ),
          );
        }
      }
    );
  }
}
