/* Demonstrating inherited widgets */

import 'package:flutter/Material.dart';

class App4 extends StatelessWidget {
  const App4({super.key});

  @override
  Widget build(BuildContext context) {
    return const AncestralTraits(
      traits: { 'surname': 'Smith', 'homeworld': 'Earth'},
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DescendantWidget('surname'),
              DescendantWidget('homeworld'),
            ]
          ),
        )
      ),
    );
  }
}


class AncestralTraits extends InheritedWidget {
  final Map<String,String> traits;
  
  const AncestralTraits({
    required this.traits, 
    required super.child, 
    super.key
  });
 
  @override
  bool updateShouldNotify(AncestralTraits oldTraits) {
    return traits != oldTraits.traits;
  }

  static AncestralTraits? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AncestralTraits>();
  }

  static AncestralTraits of(BuildContext context) {
    final AncestralTraits? result = maybeOf(context);
    assert(result != null, 'No AncestralTrait found in context');
    return result!;
  }
}


class DescendantWidget extends StatelessWidget {
  final String displayedTrait;

  const DescendantWidget(this.displayedTrait, {super.key});

  @override
  Widget build(BuildContext context) {
    String trait = AncestralTraits.of(context).traits[displayedTrait]!;
    return Text(
      'My $displayedTrait: $trait',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
