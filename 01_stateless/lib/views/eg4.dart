/* Demonstrating inherited widgets */

import 'package:flutter/Material.dart';

class App4 extends StatelessWidget {
  const App4({super.key});

  @override
  Widget build(BuildContext context) {
    return const AncestralTraits(
      // the following property is inherited by descendant widgets
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


// As an inherited widget, AncestralTraits is a widget whose properties
// are inherited by (and accessible from) its descendants.
class AncestralTraits extends InheritedWidget {
  final Map<String,String> traits;
  
  const AncestralTraits({
    required this.traits, 
    required super.child, 
    super.key
  });
 
  // This method determines whether descendant widgets should be rebuilt
  // (because descendants may depend on my properties).
  @override
  bool updateShouldNotify(AncestralTraits oldWidget) {
    return traits != oldWidget.traits;
  }

  static AncestralTraits? maybeOf(BuildContext context) {
    // This method walks up the widget tree to find the nearest ancestor
    // of type AncestralTraits.
    return context.dependOnInheritedWidgetOfExactType<AncestralTraits>();
  }

  // Expose a convenience method for accessing the nearest ancestor
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
    // The call to `AncestralTraits.of(context)` is equivalent to:
    //   context.dependOnInheritedWidgetOfExactType<AncestralTraits>()!
    String trait = AncestralTraits.of(context).traits[displayedTrait]!;
    return Text(
      'My $displayedTrait: $trait',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
