import 'package:flutter/material.dart';
import 'package:grab_bag/views/painter.dart';
import 'views/hero.dart';
import 'views/staggered.dart';
import 'views/animations.dart';
import 'views/transitions.dart';
// ignore_for_file: unused_import


void main() {
  runApp(const App());
}

// the top-level app, which uses a tab view to display the various demos
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animations',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: switch(_selectedIndex) {
            0 => const ImplicitAnimations(),
            1 => const TransitionDemo(),
            2 => const HeroPage1(),
            3 => const DrawingWidget(),
            4 => const StaggerDemo(),
            _ => const Text('Not implemented yet'),
          }
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.looks_one),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.looks_two),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.looks_3),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.looks_4),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.looks_5),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 4;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
