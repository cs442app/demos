/// An app that implements the standard drill-down menu pattern, but
/// adapts to the screen size by using different layouts.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/macguffin.dart';


class App3 extends StatelessWidget {
  const App3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App 3',
      home: ChangeNotifierProvider(
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
      ),
    );
  }
}

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

/// 
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
